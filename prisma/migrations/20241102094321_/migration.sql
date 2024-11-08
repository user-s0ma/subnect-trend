/*
  Warnings:

  - You are about to drop the column `starExpiresAt` on the `Profile` table. All the data in the column will be lost.
  - You are about to drop the column `stripeCustomerId` on the `Profile` table. All the data in the column will be lost.
  - You are about to drop the column `stripeSubscriptionId` on the `Profile` table. All the data in the column will be lost.

*/
-- DropIndex
DROP INDEX `Profile_stripeCustomerId_key` ON `Profile`;

-- DropIndex
DROP INDEX `Profile_stripeSubscriptionId_key` ON `Profile`;

-- AlterTable
ALTER TABLE `Profile` DROP COLUMN `starExpiresAt`,
    DROP COLUMN `stripeCustomerId`,
    DROP COLUMN `stripeSubscriptionId`;

-- CreateTable
CREATE TABLE `Subscription` (
    `id` VARCHAR(191) NOT NULL,
    `profileId` VARCHAR(191) NOT NULL,
    `stripeSubscriptionId` VARCHAR(191) NOT NULL,
    `stripeCustomerId` VARCHAR(191) NOT NULL,
    `planName` VARCHAR(191) NOT NULL,
    `currentPeriodEnd` DATETIME(3) NOT NULL,
    `status` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `Subscription_stripeSubscriptionId_key`(`stripeSubscriptionId`),
    PRIMARY KEY (`id`)
);

-- AddForeignKey
ALTER TABLE `Subscription` ADD CONSTRAINT `Subscription_profileId_fkey` FOREIGN KEY (`profileId`) REFERENCES `Profile`(`profileId`) ON DELETE CASCADE ON UPDATE CASCADE;
