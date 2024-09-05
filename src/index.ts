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
  wordCounts: WordCount;
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

    const recentCounts = countWordsAndPhrasesWithTimeWeight(recentPosts, fortyEightHoursAgo, now);
    const olderCounts = countWordsAndPhrasesWithTimeWeight(olderPosts, ninetySixHoursAgo, fortyEightHoursAgo);

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

function countWordsAndPhrasesWithTimeWeight(posts: PostTrend[], startTime: Date, endTime: Date): Counts {
  const wordCounts: WordCount = {};
  const phraseCounts: WordCount = {};
  const totalDuration = endTime.getTime() - startTime.getTime();

  for (const post of posts) {
    if (!post.word || post.word.trim() === "") continue;

    const timeWeight = calculateTimeWeight(post.createdAt, startTime, endTime, totalDuration);

    incrementWeightedCount(wordCounts, post.word.trim().toLowerCase(), timeWeight);

    if (post.word2 && post.word2.trim() !== "") {
      incrementWeightedCount(wordCounts, post.word2.trim().toLowerCase(), timeWeight);
      const phrase2 = `${post.word.trim().toLowerCase()} ${post.word2.trim().toLowerCase()}`;
      incrementWeightedCount(phraseCounts, phrase2, timeWeight * 4);

      if (post.word3 && post.word3.trim() !== "") {
        incrementWeightedCount(wordCounts, post.word3.trim().toLowerCase(), timeWeight);
        const phrase3 = `${post.word.trim().toLowerCase()} ${post.word2.trim().toLowerCase()} ${post.word3.trim().toLowerCase()}`;
        incrementWeightedCount(phraseCounts, phrase3, timeWeight * 8);
      }
    }
  }

  return { wordCounts, phraseCounts };
}

function calculateTimeWeight(createdAt: Date, startTime: Date, endTime: Date, totalDuration: number): number {
  const timeElapsed = createdAt.getTime() - startTime.getTime();
  const normalizedTime = timeElapsed / totalDuration;
  return 1 + (1 - normalizedTime) * 0.5;
};

function incrementWeightedCount(counts: WordCount, key: string, weight: number): void {
  counts[key] = (counts[key] || 0) + weight;
};

function calculateAdvancedTrendScores(recentCounts: Counts, olderCounts: Counts): TrendScore[] {
  const trendScores: TrendScore[] = [];
  const maxCount = Math.max(
    ...Object.values(recentCounts.wordCounts),
    ...Object.values(recentCounts.phraseCounts),
    ...Object.values(olderCounts.wordCounts),
    ...Object.values(olderCounts.phraseCounts)
  );

  function calculateScore(recent: number, older: number): number {
    const relativeIncrease = (recent - older) / (older + 1);
    const absoluteFactor = Math.log(recent + 1) / Math.log(maxCount + 1);
    const rawScore = relativeIncrease * absoluteFactor;
    return (Math.atan(rawScore) / (Math.PI / 2) + 1) / 2;
  };

  const allPhrases = new Set([
    ...Object.keys(recentCounts.wordCounts),
    ...Object.keys(recentCounts.phraseCounts),
    ...Object.keys(olderCounts.wordCounts),
    ...Object.keys(olderCounts.phraseCounts)
  ]);

  for (const phrase of allPhrases) {
    if (phrase.trim() === "") continue;

    const recentCount = (recentCounts.wordCounts[phrase] || 0) + (recentCounts.phraseCounts[phrase] || 0);
    const olderCount = (olderCounts.wordCounts[phrase] || 0) + (olderCounts.phraseCounts[phrase] || 0);

    if (recentCount === 0 && olderCount === 0) continue;

    const trendScore = calculateScore(recentCount, olderCount);
    trendScores.push({ phrase, trendScore, recentCount, olderCount });
  };

  return trendScores;
};

function removeDuplicatesAndSort(trendScores: TrendScore[]): TrendScore[] {
  const uniqueScores = new Map<string, TrendScore>();

  trendScores.sort((a, b) => b.trendScore - a.trendScore);

  for (const score of trendScores) {
    const words = score.phrase.split(" ");
    let shouldAdd = true;

    for (const [existingPhrase, existingScore] of uniqueScores) {
      const existingWords = existingPhrase.split(" ");

      if (words.length !== existingWords.length) {
        const shorterPhrase = words.length < existingWords.length ? score.phrase : existingPhrase;
        const longerPhrase = words.length < existingWords.length ? existingPhrase : score.phrase;

        if (longerPhrase.includes(shorterPhrase)) {
          if (score.trendScore > existingScore.trendScore) {
            uniqueScores.delete(existingPhrase);
          } else {
            shouldAdd = false;
            break;
          }
        }
      }
    }

    if (shouldAdd) {
      uniqueScores.set(score.phrase, score);
    }
  }

  return Array.from(uniqueScores.values());
}