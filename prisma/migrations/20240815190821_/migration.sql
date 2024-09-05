/*
  Warnings:

  - You are about to drop the `Invite` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `Invite` DROP FOREIGN KEY `Invite_profileId_fkey`;

-- DropForeignKey
ALTER TABLE `Invite` DROP FOREIGN KEY `Invite_usedId_fkey`;

-- DropTable
DROP TABLE `Invite`;

-- CreateTable
CREATE TABLE `PostEditHistory` (
    `editId` VARCHAR(191) NOT NULL,
    `postId` VARCHAR(191) NOT NULL,
    `text` TEXT NOT NULL,
    `editedAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `PostEditHistory_postId_idx`(`postId`),
    PRIMARY KEY (`editId`)
);

-- AddForeignKey
ALTER TABLE `PostEditHistory` ADD CONSTRAINT `PostEditHistory_postId_fkey` FOREIGN KEY (`postId`) REFERENCES `Post`(`postId`) ON DELETE CASCADE ON UPDATE CASCADE;
