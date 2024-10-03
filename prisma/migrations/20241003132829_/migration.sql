/*
  Warnings:

  - You are about to drop the column `medium` on the `AssetImage` table. All the data in the column will be lost.
  - You are about to drop the column `thumb` on the `AssetImage` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE `AssetImage` DROP COLUMN `medium`,
    DROP COLUMN `thumb`;

-- AlterTable
ALTER TABLE `Message` MODIFY `text` TEXT NULL;

-- AlterTable
ALTER TABLE `Post` ADD COLUMN `scopeListId` VARCHAR(191) NULL;

-- AddForeignKey
ALTER TABLE `Post` ADD CONSTRAINT `Post_scopeListId_fkey` FOREIGN KEY (`scopeListId`) REFERENCES `List`(`listId`) ON DELETE CASCADE ON UPDATE CASCADE;
