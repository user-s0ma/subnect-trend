-- DropForeignKey
ALTER TABLE `Post` DROP FOREIGN KEY `Post_scopeListId_fkey`;

-- AlterTable
ALTER TABLE `Post` MODIFY `scope` VARCHAR(191) NULL;

-- AddForeignKey
ALTER TABLE `Post` ADD CONSTRAINT `Post_scopeListId_fkey` FOREIGN KEY (`scopeListId`) REFERENCES `List`(`listId`) ON DELETE SET NULL ON UPDATE CASCADE;
