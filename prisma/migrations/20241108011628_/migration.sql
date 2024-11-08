/*
  Warnings:

  - You are about to drop the column `senderId` on the `Message` table. All the data in the column will be lost.
  - You are about to drop the column `violation` on the `Message` table. All the data in the column will be lost.
  - You are about to drop the column `receiverId` on the `MessageHidden` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[profileId,senderId]` on the table `MessageHidden` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `profileId` to the `Message` table without a default value. This is not possible if the table is not empty.
  - Added the required column `senderId` to the `MessageHidden` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `Message` DROP FOREIGN KEY `Message_senderId_fkey`;

-- DropForeignKey
ALTER TABLE `MessageHidden` DROP FOREIGN KEY `MessageHidden_receiverId_fkey`;

-- DropIndex
DROP INDEX `MessageHidden_profileId_receiverId_key` ON `MessageHidden`;

-- RenameColumn and DropColumn
ALTER TABLE `Message` 
    RENAME COLUMN `senderId` TO `profileId`,
    DROP COLUMN `violation`;

-- RenameColumn
ALTER TABLE `MessageHidden` RENAME COLUMN `receiverId` TO `senderId`;

-- CreateIndex
CREATE INDEX `Message_profileId_idx` ON `Message`(`profileId`);

-- CreateIndex
CREATE INDEX `MessageHidden_senderId_idx` ON `MessageHidden`(`senderId`);

-- CreateIndex
CREATE UNIQUE INDEX `MessageHidden_profileId_senderId_key` ON `MessageHidden`(`profileId`, `senderId`);

-- AddForeignKey
ALTER TABLE `Message` ADD CONSTRAINT `Message_profileId_fkey` FOREIGN KEY (`profileId`) REFERENCES `Profile`(`profileId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `MessageHidden` ADD CONSTRAINT `MessageHidden_senderId_fkey` FOREIGN KEY (`senderId`) REFERENCES `Profile`(`profileId`) ON DELETE CASCADE ON UPDATE CASCADE;
