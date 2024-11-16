/*
  Warnings:

  - Added the required column `adName` to the `AdPost` table without a default value. This is not possible if the table is not empty.

*/
-- Step 1: Add column with temporary default
ALTER TABLE `AdPost` ADD COLUMN `adName` VARCHAR(191) NOT NULL DEFAULT 'default';

-- Step 2: Remove the default constraint
ALTER TABLE `AdPost` ALTER COLUMN `adName` DROP DEFAULT;
