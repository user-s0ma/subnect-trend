/*
  Warnings:

  - You are about to drop the column `nextWord` on the `PostTrend` table. All the data in the column will be lost.

*/
-- DropIndex
DROP INDEX `PostTrend_word_nextWord_idx` ON `PostTrend`;

-- AlterTable
ALTER TABLE `PostTrend` DROP COLUMN `nextWord`,
    ADD COLUMN `word2` VARCHAR(191) NULL,
    ADD COLUMN `word3` VARCHAR(191) NULL;

-- CreateIndex
CREATE INDEX `PostTrend_word_word2_idx` ON `PostTrend`(`word`, `word2`);

-- CreateIndex
CREATE INDEX `PostTrend_word_word2_word3_idx` ON `PostTrend`(`word`, `word2`, `word3`);
