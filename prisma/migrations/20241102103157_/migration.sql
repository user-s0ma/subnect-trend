/*
  Warnings:

  - A unique constraint covering the columns `[profileId]` on the table `Subscription` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX `Subscription_profileId_key` ON `Subscription`(`profileId`);
