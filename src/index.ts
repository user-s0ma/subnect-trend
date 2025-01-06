import { PrismaClient } from "@prisma/client";
import { PrismaTiDBCloud } from "@tidbcloud/prisma-adapter";
import { connect } from "@tidbcloud/serverless";

interface Env {
  DATABASE_URL: string;
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

    const languages = ["en", "ja"];

    const recentCountsByLanguage = await Promise.all(
      languages.map(async (lang) => {
        const data = await prisma.postTrendWord.groupBy({
          by: ["language", "word"],
          where: {
            createdAt: {
              gte: fortyEightHoursAgo,
            },
            language: lang,
          },
          take: 10,
          _count: {
            word: true,
          },
          orderBy: {
            _count: {
              word: "desc",
            },
          },
        });
    
        return data.map((record) => ({
          phrase: record.word,
          recentCount: record._count.word,
          language: lang,
        }));
      })
    );
    
    const topTrends = recentCountsByLanguage.flat();
    
    await prisma.postTrend.deleteMany({});
    await prisma.postTrend.createMany({
      data: topTrends.map((trend) => ({
        word: trend.phrase,
        postCount: trend.recentCount,
        language: trend.language,
      })),
    });
  }
};