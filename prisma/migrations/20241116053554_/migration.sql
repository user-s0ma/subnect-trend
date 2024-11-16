/*
  Warnings:

  - You are about to drop the column `url` on the `AdHeader` table. All the data in the column will be lost.
  - You are about to drop the column `url` on the `AdPost` table. All the data in the column will be lost.
  - You are about to drop the column `ad` on the `Post` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE `AdHeader` DROP COLUMN `url`,
    ADD COLUMN `urlId` VARCHAR(191) NULL;

-- AlterTable
ALTER TABLE `AdPost` DROP COLUMN `url`,
    ADD COLUMN `urlId` VARCHAR(191) NULL;

-- AlterTable
ALTER TABLE `Post` DROP COLUMN `ad`;

-- CreateTable
CREATE TABLE `AdUrl` (
    `urlId` VARCHAR(191) NOT NULL,
    `url` TEXT NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `AdUrl_urlId_idx`(`urlId`),
    PRIMARY KEY (`urlId`)
);

-- CreateTable
CREATE TABLE `AdClick` (
    `clickId` VARCHAR(191) NOT NULL,
    `profileId` VARCHAR(191) NOT NULL,
    `urlId` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `AdClick_profileId_idx`(`profileId`),
    INDEX `AdClick_urlId_idx`(`urlId`),
    INDEX `AdClick_createdAt_idx`(`createdAt`),
    PRIMARY KEY (`clickId`)
);

-- AddForeignKey
ALTER TABLE `AdClick` ADD CONSTRAINT `AdClick_profileId_fkey` FOREIGN KEY (`profileId`) REFERENCES `Profile`(`profileId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `AdClick` ADD CONSTRAINT `AdClick_urlId_fkey` FOREIGN KEY (`urlId`) REFERENCES `AdUrl`(`urlId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `AdPost` ADD CONSTRAINT `AdPost_urlId_fkey` FOREIGN KEY (`urlId`) REFERENCES `AdUrl`(`urlId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `AdHeader` ADD CONSTRAINT `AdHeader_urlId_fkey` FOREIGN KEY (`urlId`) REFERENCES `AdUrl`(`urlId`) ON DELETE CASCADE ON UPDATE CASCADE;
