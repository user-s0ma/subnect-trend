/*
  Warnings:

  - You are about to drop the column `messageToFollowersOnly` on the `ProfileSettings` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE `ProfileSettings` DROP COLUMN `messageToFollowersOnly`,
    ADD COLUMN `messagesFollowingOnly` BOOLEAN NOT NULL DEFAULT false;
