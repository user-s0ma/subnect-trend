/*
  Warnings:

  - You are about to drop the column `repliesCount` on the `Post` table. All the data in the column will be lost.
  - You are about to drop the column `bio` on the `Profile` table. All the data in the column will be lost.
  - You are about to drop the column `nickname` on the `Profile` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[apId]` on the table `Asset` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[apId]` on the table `Post` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[apId]` on the table `Profile` will be added. If there are existing duplicate values, this will fail.

*/
-- DropForeignKey
ALTER TABLE `Profile` DROP FOREIGN KEY `Profile_iconId_fkey`;

-- AlterTable
ALTER TABLE `Asset` ADD COLUMN `apId` VARCHAR(191) NULL,
    ADD COLUMN `assetType` VARCHAR(191) NULL;

-- AlterTable
ALTER TABLE `Post`
    RENAME COLUMN `repliesCount` TO `replyCount`,
    ADD COLUMN `apId` VARCHAR(191) NULL;

-- AlterTable
ALTER TABLE `Profile`
    RENAME COLUMN `bio` TO `description`,
    RENAME COLUMN `nickname` TO `displayName`,
    ADD COLUMN `apDomain` VARCHAR(191) NULL,
    ADD COLUMN `apFollowersUrl` VARCHAR(191) NULL,
    ADD COLUMN `apId` VARCHAR(191) NULL,
    ADD COLUMN `apInboxUrl` VARCHAR(191) NULL,
    ADD COLUMN `apOutboxUrl` VARCHAR(191) NULL,
    ADD COLUMN `apPublicKey` TEXT NULL,
    MODIFY `userId` VARCHAR(191) NULL,
    MODIFY `iconId` VARCHAR(191) NULL;

-- CreateTable
CREATE TABLE `ActivityPubDomain` (
    `domainId` VARCHAR(191) NOT NULL,
    `domain` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `ActivityPubDomain_domain_key`(`domain`),
    INDEX `ActivityPubDomain_domain_idx`(`domain`),
    PRIMARY KEY (`domainId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateIndex
CREATE UNIQUE INDEX `Asset_apId_key` ON `Asset`(`apId`);

-- CreateIndex
CREATE UNIQUE INDEX `Post_apId_key` ON `Post`(`apId`);

-- CreateIndex
CREATE UNIQUE INDEX `Profile_apId_key` ON `Profile`(`apId`);

-- AddForeignKey
ALTER TABLE `Profile` ADD CONSTRAINT `Profile_iconId_fkey` FOREIGN KEY (`iconId`) REFERENCES `Asset`(`assetId`) ON DELETE SET NULL ON UPDATE CASCADE;
