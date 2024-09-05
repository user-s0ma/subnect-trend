/*
  Warnings:

  - Added the required column `postCount` to the `Trend` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `Trend` ADD COLUMN `postCount` INTEGER NOT NULL DEFAULT 0;
