/*
  Warnings:

  - A unique constraint covering the columns `[stripeCustomerId]` on the table `Profile` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[stripeSubscriptionId]` on the table `Profile` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE `Profile` ADD COLUMN `stripeCustomerId` VARCHAR(191) NULL;

-- CreateIndex
CREATE UNIQUE INDEX `Profile_stripeCustomerId_key` ON `Profile`(`stripeCustomerId`);

-- CreateIndex
CREATE UNIQUE INDEX `Profile_stripeSubscriptionId_key` ON `Profile`(`stripeSubscriptionId`);
