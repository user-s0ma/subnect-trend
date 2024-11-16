/*
  Warnings:

  - The primary key for the `PostTrend` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `PostTrend` table. All the data in the column will be lost.
  - The primary key for the `Subscription` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `Subscription` table. All the data in the column will be lost.
  - You are about to drop the `Trend` table. If the table is not empty, all the data it contains will be lost.
  - The required column `trendId` was added to the `PostTrend` table with a prisma-level default value. This is not possible if the table is not empty. Please add this column as optional, then populate it before making it required.
  - The required column `subscriptionId` was added to the `Subscription` table with a prisma-level default value. This is not possible if the table is not empty. Please add this column as optional, then populate it before making it required.

*/
-- DropTable
DROP TABLE `PostTrend`;

-- CreateTable
CREATE TABLE `PostTrend` (
    `trendId` VARCHAR(191) NOT NULL,
    `word` VARCHAR(191) NOT NULL,
    `postCount` INTEGER NOT NULL DEFAULT 0,
    `language` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `PostTrend_createdAt_idx`(`createdAt`),
    PRIMARY KEY (`trendId`)
);

-- DropTable
DROP TABLE `Subscription`;

-- CreateTable
CREATE TABLE `Subscription` (
    `subscriptionId` VARCHAR(191) NOT NULL,
    `profileId` VARCHAR(191) NOT NULL,
    `stripeSubscriptionId` VARCHAR(191) NOT NULL,
    `stripeCustomerId` VARCHAR(191) NOT NULL,
    `planName` VARCHAR(191) NOT NULL,
    `currentPeriodEnd` DATETIME(3) NOT NULL,
    `status` VARCHAR(191) NOT NULL,
    `cancelAtPeriodEnd` BOOLEAN NOT NULL DEFAULT false,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `Subscription_profileId_key`(`profileId`),
    UNIQUE INDEX `Subscription_stripeSubscriptionId_key`(`stripeSubscriptionId`),
    PRIMARY KEY (`subscriptionId`)
);

-- DropTable
DROP TABLE `Trend`;

-- CreateTable
CREATE TABLE `PostTrendWord` (
    `wordId` VARCHAR(191) NOT NULL,
    `word` VARCHAR(191) NOT NULL,
    `language` VARCHAR(191) NOT NULL DEFAULT 'en',
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `PostTrendWord_word_idx`(`word`),
    INDEX `PostTrendWord_createdAt_idx`(`createdAt`),
    PRIMARY KEY (`wordId`)
);
