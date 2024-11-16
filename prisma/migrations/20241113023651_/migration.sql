-- CreateTable
CREATE TABLE `AdPost` (
    `adId` VARCHAR(191) NOT NULL,
    `profileId` VARCHAR(191) NOT NULL,
    `postId` VARCHAR(191) NOT NULL,
    `url` TEXT NOT NULL,
    `budget` DOUBLE NOT NULL,
    `startDate` DATETIME(3) NOT NULL,
    `endDate` DATETIME(3) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `AdPost_profileId_idx`(`profileId`),
    INDEX `AdPost_postId_idx`(`postId`),
    PRIMARY KEY (`adId`)
);

-- CreateTable
CREATE TABLE `AdHeader` (
    `adId` VARCHAR(191) NOT NULL,
    `profileId` VARCHAR(191) NOT NULL,
    `assetId` VARCHAR(191) NOT NULL,
    `text` TEXT NULL,
    `url` TEXT NOT NULL,
    `budget` DOUBLE NOT NULL,
    `startDate` DATETIME(3) NOT NULL,
    `endDate` DATETIME(3) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `AdHeader_profileId_idx`(`profileId`),
    PRIMARY KEY (`adId`)
);

-- AddForeignKey
ALTER TABLE `AdPost` ADD CONSTRAINT `AdPost_profileId_fkey` FOREIGN KEY (`profileId`) REFERENCES `Profile`(`profileId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `AdPost` ADD CONSTRAINT `AdPost_postId_fkey` FOREIGN KEY (`postId`) REFERENCES `Post`(`postId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `AdHeader` ADD CONSTRAINT `AdHeader_profileId_fkey` FOREIGN KEY (`profileId`) REFERENCES `Profile`(`profileId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `AdHeader` ADD CONSTRAINT `AdHeader_assetId_fkey` FOREIGN KEY (`assetId`) REFERENCES `Asset`(`assetId`) ON DELETE RESTRICT ON UPDATE CASCADE;
