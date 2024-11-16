/*
  Warnings:

  - You are about to drop the `AdClick` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `AdClick` DROP FOREIGN KEY `AdClick_profileId_fkey`;

-- DropForeignKey
ALTER TABLE `AdClick` DROP FOREIGN KEY `AdClick_urlId_fkey`;

-- DropTable
DROP TABLE `AdClick`;

-- CreateTable
CREATE TABLE `AdUrlView` (
    `viewId` VARCHAR(191) NOT NULL,
    `profileId` VARCHAR(191) NOT NULL,
    `urlId` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `AdUrlView_profileId_idx`(`profileId`),
    INDEX `AdUrlView_urlId_idx`(`urlId`),
    INDEX `AdUrlView_createdAt_idx`(`createdAt`),
    PRIMARY KEY (`viewId`)
);

-- CreateTable
CREATE TABLE `AdPostRead` (
    `readId` VARCHAR(191) NOT NULL,
    `profileId` VARCHAR(191) NULL,
    `adId` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `AdPostRead_profileId_idx`(`profileId`),
    INDEX `AdPostRead_createdAt_idx`(`createdAt`),
    PRIMARY KEY (`readId`)
);

-- AddForeignKey
ALTER TABLE `AdUrlView` ADD CONSTRAINT `AdUrlView_profileId_fkey` FOREIGN KEY (`profileId`) REFERENCES `Profile`(`profileId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `AdUrlView` ADD CONSTRAINT `AdUrlView_urlId_fkey` FOREIGN KEY (`urlId`) REFERENCES `AdUrl`(`urlId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `AdPostRead` ADD CONSTRAINT `AdPostRead_profileId_fkey` FOREIGN KEY (`profileId`) REFERENCES `Profile`(`profileId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `AdPostRead` ADD CONSTRAINT `AdPostRead_adId_fkey` FOREIGN KEY (`adId`) REFERENCES `AdPost`(`adId`) ON DELETE CASCADE ON UPDATE CASCADE;
