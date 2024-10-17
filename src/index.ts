import { PrismaClient, PostTrend } from "@prisma/client";
import { PrismaTiDBCloud } from "@tidbcloud/prisma-adapter";
import { connect } from "@tidbcloud/serverless";

interface Env {
  DATABASE_URL: string;
};

interface WordCount {
  [word: string]: number;
};

interface Counts {
  [language: string]: {
    phraseCounts: WordCount;
  };
};

interface TrendScore {
  phrase: string;
  trendScore: number;
  recentCount: number;
  olderCount: number;
  language: string;
};

export default {
  async scheduled(event: ScheduledEvent, env: Env, ctx: EventContext<Env, any, any>) {
    const connection = connect({ url: env.DATABASE_URL });
    const adapter = new PrismaTiDBCloud(connection);
    const prisma = new PrismaClient({ adapter });

    const now = new Date();
    const fortyEightHoursAgo = new Date(now.getTime() - 48 * 60 * 60 * 1000);
    const ninetySixHoursAgo = new Date(now.getTime() - 96 * 60 * 60 * 1000);

    const recentPosts = await prisma.postTrend.findMany({
      where: {
        createdAt: {
          gte: fortyEightHoursAgo,
        },
      },
      take: 10000,
    });

    const olderPosts = await prisma.postTrend.findMany({
      where: {
        createdAt: {
          gte: ninetySixHoursAgo,
          lt: fortyEightHoursAgo,
        },
      },
      take: 10000,
    });

    const recentCounts = countWordsAndPhrases(recentPosts);
    const olderCounts = countWordsAndPhrases(olderPosts);

    let trendScores = calculateTrendScores(recentCounts, olderCounts);

    trendScores = removeDuplicatesAndSort(trendScores);

    const topTrends = trendScores.slice(0, 10);

    const trendPostCounts = await Promise.all(
      topTrends.map(async (trend) => {
        const postCount = await prisma.post.count({
          where: {
            text: {
              contains: trend.phrase,
            },
            language: trend.language,
            createdAt: {
              gt: fortyEightHoursAgo,
            },
          },
        });
        return { ...trend, postCount };
      })
    );
    
    await prisma.trend.deleteMany({});
    await prisma.trend.createMany({
      data: trendPostCounts.map((trend) => ({
        word: trend.phrase,
        postCount: trend.postCount,
        language: trend.language,
      })),
    });
  },
};

function countWordsAndPhrases(posts: PostTrend[]): Counts {
  const counts: Counts = {};

  for (const post of posts) {
    if (!post.word || post.word.trim() === "") continue;
    const word = post.word.trim();
    const language = post.language || null;

    if (!counts[language]) {
      counts[language] = { phraseCounts: {} };
    }

    counts[language].phraseCounts[word] = (counts[language].phraseCounts[word] || 0) + 1;
  }

  return counts;
}

function calculateTrendScores(recentCounts: Counts, olderCounts: Counts): TrendScore[] {
  const trendScores: TrendScore[] = [];

  for (const language in recentCounts) {
    const recentPhraseCounts = recentCounts[language].phraseCounts;
    const olderPhraseCounts = olderCounts[language]?.phraseCounts || {};

    const allPhrases = new Set([
      ...Object.keys(recentPhraseCounts),
      ...Object.keys(olderPhraseCounts),
    ]);

    for (const phrase of allPhrases) {
      if (phrase.trim() === "") continue;

      const recentCount = recentPhraseCounts[phrase] || 0;
      const olderCount = olderPhraseCounts[phrase] || 0;
      const increase = recentCount - olderCount;

      if (increase > 0) {
        trendScores.push({
          phrase,
          trendScore: increase,
          recentCount,
          olderCount,
          language,
        });
      }
    }
  }

  return trendScores;
}

function removeDuplicatesAndSort(trendScores: TrendScore[]): TrendScore[] {
  const uniqueScores = new Map<string, TrendScore>();

  trendScores.sort((a, b) => b.trendScore - a.trendScore);

  for (const score of trendScores) {
    const key = `${score.language}-${score.phrase}`;
    if (!uniqueScores.has(key)) {
      uniqueScores.set(key, score);
    }
  }

  return Array.from(uniqueScores.values());
}