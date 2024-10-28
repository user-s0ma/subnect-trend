/*
  Warnings:

  - You are about to drop the column `subscriptionEndAt` on the `Profile` table. All the data in the column will be lost.
  - You are about to drop the `AuthVerificationIP` table. If the table is not empty, all the data it contains will be lost.

*/
-- AlterTable
ALTER TABLE `AuthUser` ADD COLUMN `admin` BOOLEAN NOT NULL DEFAULT false;

-- AlterTable
ALTER TABLE `Profile` DROP COLUMN `subscriptionEndAt`,
    ADD COLUMN `starExpiresAt` DATETIME(3) NULL;

-- AlterTable
ALTER TABLE `ReportPost` ADD COLUMN `category` VARCHAR(191) NULL;

-- AlterTable
ALTER TABLE `ReportProfile` ADD COLUMN `category` VARCHAR(191) NULL;

-- DropTable
DROP TABLE `AuthVerificationIP`;

-- CreateTable
CREATE TABLE `MessageReaction` (
    `reactionId` VARCHAR(191) NOT NULL,
    `messageId` VARCHAR(191) NOT NULL,
    `profileId` VARCHAR(191) NOT NULL,
    `emoji` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `MessageReaction_messageId_idx`(`messageId`),
    INDEX `MessageReaction_profileId_idx`(`profileId`),
    UNIQUE INDEX `MessageReaction_messageId_profileId_key`(`messageId`, `profileId`),
    PRIMARY KEY (`reactionId`)
);

-- AddForeignKey
ALTER TABLE `MessageReaction` ADD CONSTRAINT `MessageReaction_messageId_fkey` FOREIGN KEY (`messageId`) REFERENCES `Message`(`messageId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `MessageReaction` ADD CONSTRAINT `MessageReaction_profileId_fkey` FOREIGN KEY (`profileId`) REFERENCES `Profile`(`profileId`) ON DELETE CASCADE ON UPDATE CASCADE;
