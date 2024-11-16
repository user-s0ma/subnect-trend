/*
  Warnings:

  - You are about to drop the column `adName` on the `AdHeader` table. All the data in the column will be lost.
  - You are about to drop the column `adName` on the `AdPost` table. All the data in the column will be lost.
  - Added the required column `name` to the `AdHeader` table without a default value. This is not possible if the table is not empty.
  - Added the required column `name` to the `AdPost` table without a default value. This is not possible if the table is not empty.

*/
-- AdHeaderテーブルのカラム名変更
ALTER TABLE `AdHeader` RENAME COLUMN `adName` TO `name`;

-- AdPostテーブルのカラム名変更
ALTER TABLE `AdPost` RENAME COLUMN `adName` TO `name`;
