import { PrismaClient } from "@prisma/client";
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

    const recentCountsRaw = await prisma.postTrendWord.groupBy({
      by: ["language", "word"],
      where: {
        createdAt: {
          gte: fortyEightHoursAgo,
        },
      },
      take: 1000,
      _count: {
        word: true
      },
      orderBy: {
        _count: {
          word: "desc",
        },
      }
    });

    const olderCountsRaw = await prisma.postTrendWord.groupBy({
      by: ["language", "word"],
      where: {
        createdAt: {
          gte: ninetySixHoursAgo,
          lt: fortyEightHoursAgo,
        },
      },
      take: 1000,
      _count: {
        word: true
      },
      orderBy: {
        _count: {
          word: "desc",
        },
      }
    });

    const recentCounts = convertGroupByResultsToCounts(recentCountsRaw);
    const olderCounts = convertGroupByResultsToCounts(olderCountsRaw);

    const trendScores = calculateTrendScores(recentCounts, olderCounts);

    const topTrends = trendScores.sort((a, b) => b.trendScore - a.trendScore).slice(0, 10);

    await prisma.postTrend.deleteMany({});
    await prisma.postTrend.createMany({
      data: topTrends.map((trend) => ({
        word: trend.phrase,
        postCount: trend.recentCount,
        language: trend.language,
      })),
    });
  },
};

function convertGroupByResultsToCounts(groupedData: { language: string | null, word: string, _count: { word: number } }[]): Counts {
  const counts: Counts = {};
  for (const record of groupedData) {
    const language = record.language || null;

    if (!counts[language]) {
      counts[language] = { phraseCounts: {} };
    }
    counts[language].phraseCounts[record.word] = record._count.word;
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
          language,
        });
      }
    }
  }

  return trendScores;
}