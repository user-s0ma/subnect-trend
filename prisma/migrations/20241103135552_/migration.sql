/*
  Warnings:

  - You are about to drop the column `senderId` on the `MessageHidden` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[profileId,receiverId]` on the table `MessageHidden` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `profileId` to the `MessageHidden` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `MessageHidden` DROP FOREIGN KEY `MessageHidden_senderId_fkey`;

-- AlterTable
ALTER TABLE `MessageHidden` DROP COLUMN `senderId`,
    ADD COLUMN `profileId` VARCHAR(191) NOT NULL;

-- CreateIndex
CREATE INDEX `MessageHidden_profileId_idx` ON `MessageHidden`(`profileId`);

-- CreateIndex
CREATE UNIQUE INDEX `MessageHidden_profileId_receiverId_key` ON `MessageHidden`(`profileId`, `receiverId`);

-- AddForeignKey
ALTER TABLE `MessageHidden` ADD CONSTRAINT `MessageHidden_profileId_fkey` FOREIGN KEY (`profileId`) REFERENCES `Profile`(`profileId`) ON DELETE CASCADE ON UPDATE CASCADE;
