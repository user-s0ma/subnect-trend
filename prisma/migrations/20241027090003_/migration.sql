/*
  Warnings:

  - You are about to drop the column `category` on the `Asset` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE `Asset` DROP COLUMN `category`,
    ADD COLUMN `public` BOOLEAN NOT NULL DEFAULT true;

-- AlterTable
ALTER TABLE `ProfileSettings` MODIFY `backColor` VARCHAR(191) NOT NULL DEFAULT 'E6E6E6';

-- CreateTable
CREATE TABLE `AdminLog` (
    `logId` VARCHAR(191) NOT NULL,
    `userId` VARCHAR(191) NOT NULL,
    `log` TEXT NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `AdminLog_userId_idx`(`userId`),
    INDEX `AdminLog_createdAt_idx`(`createdAt`),
    PRIMARY KEY (`logId`)
);

-- AddForeignKey
ALTER TABLE `AdminLog` ADD CONSTRAINT `AdminLog_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `AuthUser`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
