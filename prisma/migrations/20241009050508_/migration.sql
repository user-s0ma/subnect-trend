/*
  Warnings:

  - Made the column `violation` on table `Post` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE `Post` MODIFY `violation` BOOLEAN NOT NULL DEFAULT false;
