/*
  Warnings:

  - You are about to drop the column `readCount` on the `Post` table. All the data in the column will be lost.
  - You are about to drop the column `viewCount` on the `Post` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE `Post` DROP COLUMN `readCount`,
    DROP COLUMN `viewCount`,
    ADD COLUMN `ad` BOOLEAN NOT NULL DEFAULT false;
