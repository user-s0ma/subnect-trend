/*
  Warnings:

  - You are about to drop the column `mutualFollowOnlyMessages` on the `ProfileSettings` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE `ProfileSettings` DROP COLUMN `mutualFollowOnlyMessages`,
    ADD COLUMN `messageToFollowersOnly` BOOLEAN NOT NULL DEFAULT false;
