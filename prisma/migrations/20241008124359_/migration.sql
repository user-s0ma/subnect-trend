/*
  Warnings:

  - You are about to drop the column `replyToId` on the `MessageHidden` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE `MessageHidden` DROP COLUMN `replyToId`;
