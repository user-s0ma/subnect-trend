/*
  Warnings:

  - You are about to drop the column `userId` on the `Asset` table. All the data in the column will be lost.
  - Added the required column `appView` to the `Notification` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `Asset` DROP FOREIGN KEY `Asset_userId_fkey`;

-- AlterTable
ALTER TABLE `Asset` DROP COLUMN `userId`,
    ADD COLUMN `profileId` VARCHAR(191) NULL;

-- AlterTable
ALTER TABLE `Notification` ADD COLUMN `appView` BOOLEAN NOT NULL DEFAULT true;

-- CreateIndex
CREATE INDEX `Asset_profileId_idx` ON `Asset`(`profileId`);

-- AddForeignKey
ALTER TABLE `Asset` ADD CONSTRAINT `Asset_profileId_fkey` FOREIGN KEY (`profileId`) REFERENCES `Profile`(`profileId`) ON DELETE CASCADE ON UPDATE CASCADE;
