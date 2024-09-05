/*
  Warnings:

  - You are about to drop the column `CustomColor` on the `ProfileSettings` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE `ProfileSettings` DROP COLUMN `customColor`;
ALTER TABLE `ProfileSettings` ADD COLUMN `customColor` BOOLEAN NOT NULL DEFAULT false;
