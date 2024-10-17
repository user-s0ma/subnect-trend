/*
  Warnings:

  - You are about to drop the column `profileId` on the `PostTrend` table. All the data in the column will be lost.
  - You are about to drop the column `word2` on the `PostTrend` table. All the data in the column will be lost.
  - You are about to drop the column `word3` on the `PostTrend` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE `PostTrend` DROP FOREIGN KEY `PostTrend_profileId_fkey`;

-- DropIndex
DROP INDEX `PostTrend_word_word2_idx` ON `PostTrend`;

-- DropIndex
DROP INDEX `PostTrend_word_word2_word3_idx` ON `PostTrend`;

-- AlterTable
ALTER TABLE `PostTrend` DROP COLUMN `profileId`,
    DROP COLUMN `word2`,
    DROP COLUMN `word3`,
    ADD COLUMN `language` VARCHAR(191) NOT NULL DEFAULT 'en';
