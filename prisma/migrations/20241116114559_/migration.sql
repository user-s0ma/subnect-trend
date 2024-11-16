/*
  Warnings:

  - You are about to drop the column `bannedAt` on the `AuthBanEmail` table. All the data in the column will be lost.
  - You are about to drop the column `bannedAt` on the `AuthBanIP` table. All the data in the column will be lost.
  - You are about to drop the column `editedAt` on the `PostEditHistory` table. All the data in the column will be lost.
  - You are about to drop the column `viewedAt` on the `PostView` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE `AuthBanEmail` DROP COLUMN `bannedAt`,
    ADD COLUMN `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3);

-- AlterTable
ALTER TABLE `AuthBanIP` DROP COLUMN `bannedAt`,
    ADD COLUMN `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3);

-- AlterTable
ALTER TABLE `PostEditHistory` DROP COLUMN `editedAt`,
    ADD COLUMN `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3);

-- AlterTable
ALTER TABLE `PostView` DROP COLUMN `viewedAt`,
    ADD COLUMN `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3);
