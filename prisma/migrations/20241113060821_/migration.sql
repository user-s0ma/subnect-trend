/*
  Warnings:

  - Added the required column `adName` to the `AdHeader` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `AdHeader` ADD COLUMN `adName` VARCHAR(191) NOT NULL;
