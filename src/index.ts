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
  phraseCounts: WordCount;
};

interface TrendScore {
  phrase: string;
  trendScore: number;
  recentCount: number;
  olderCount: number;
};

export default {
  async scheduled(event: any, env: Env, ctx: any) {
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
      take: 1000000,
    });

    const olderPosts = await prisma.postTrend.findMany({
      where: {
        createdAt: {
          gte: ninetySixHoursAgo,
          lt: fortyEightHoursAgo,
        },
      },
      take: 1000000,
    });

    const recentCounts = countWordsAndPhrasesWithTimeWeight(recentPosts);
    const olderCounts = countWordsAndPhrasesWithTimeWeight(olderPosts);

    let trendScores = calculateAdvancedTrendScores(recentCounts, olderCounts);

    trendScores = removeDuplicatesAndSort(trendScores);

    const topTrends = trendScores.slice(0, 10);

    const trendPostCounts = await Promise.all(topTrends.map(async (trend) => {
      const words = trend.phrase.split(" ");
      const postCount = await prisma.post.count({
        where: {
          AND: words.map(word => ({
            text: {
              contains: word,
            }
          })),
          createdAt: {
            gt: fortyEightHoursAgo,
          },
        },
      });
      return { ...trend, postCount };
    }));

    await prisma.trend.deleteMany({});

    await prisma.trend.createMany({
      data: trendPostCounts.map(trend => ({
        word: trend.phrase,
        postCount: trend.postCount,
      })),
    });
  },
};

function countWordsAndPhrasesWithTimeWeight(posts: PostTrend[]): Counts {
  const phraseCounts: WordCount = {};

  for (const post of posts) {
    if (!post.word || post.word.trim() === "") continue;
    phraseCounts[post.word.trim().toLowerCase()] = (phraseCounts[post.word.trim().toLowerCase()] || 0) + 1;
    if (post.word2 && post.word2.trim() !== "") {
      const phrase2 = `${post.word.trim().toLowerCase()} ${post.word2.trim().toLowerCase()}`;
      phraseCounts[phrase2] = (phraseCounts[phrase2] || 0) + 1.5;
      if (post.word3 && post.word3.trim() !== "") {
        const phrase3 = `${post.word.trim().toLowerCase()} ${post.word2.trim().toLowerCase()} ${post.word3.trim().toLowerCase()}`;
        phraseCounts[phrase3] = (phraseCounts[phrase3] || 0) + 3;
      }
    }
  }

  return { phraseCounts };
}

function calculateAdvancedTrendScores(recentCounts: Counts, olderCounts: Counts): TrendScore[] {
  const trendScores: TrendScore[] = [];
  const maxCount = Math.max(
    ...Object.values(recentCounts.phraseCounts),
    ...Object.values(olderCounts.phraseCounts)
  );

  const allPhrases = new Set([
    ...Object.keys(recentCounts.phraseCounts),
    ...Object.keys(olderCounts.phraseCounts)
  ]);

  for (const phrase of allPhrases) {
    if (phrase.trim() === "") continue;

    const recentCount = (recentCounts.phraseCounts[phrase] || 0);
    const olderCount = (olderCounts.phraseCounts[phrase] || 0);

    if (recentCount === 0 && olderCount === 0) continue;
    
    const trendScore = recentCount - olderCount;
    trendScores.push({ phrase, trendScore, recentCount, olderCount });
  };

  return trendScores;
};

function removeDuplicatesAndSort(trendScores: TrendScore[]): TrendScore[] {
  const uniqueScores = new Map<string, TrendScore>();

  trendScores.sort((a, b) => b.trendScore - a.trendScore);

  for (const score of trendScores) {
    uniqueScores.set(score.phrase, score);
  }

  return Array.from(uniqueScores.values());
}