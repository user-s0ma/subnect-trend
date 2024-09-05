/*
  Warnings:

  - Added the required column `profileId` to the `PostTrend` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `PostTrend` ADD COLUMN `profileId` VARCHAR(191) NOT NULL;

-- CreateTable
CREATE TABLE `Trend` (
    `id` VARCHAR(191) NOT NULL,
    `word` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `Trend_createdAt_idx`(`createdAt`),
    PRIMARY KEY (`id`)
);

-- CreateIndex
CREATE INDEX `PostTrend_createdAt_idx` ON `PostTrend`(`createdAt`);

-- AddForeignKey
ALTER TABLE `PostTrend` ADD CONSTRAINT `PostTrend_profileId_fkey` FOREIGN KEY (`profileId`) REFERENCES `Profile`(`profileId`) ON DELETE CASCADE ON UPDATE CASCADE;
