-- CreateIndex
CREATE INDEX `AuthBanEmail_email_idx` ON `AuthBanEmail`(`email`);

-- CreateIndex
CREATE INDEX `AuthBanIP_ip_idx` ON `AuthBanIP`(`ip`);

-- CreateIndex
CREATE INDEX `AuthChangeEmail_userId_idx` ON `AuthChangeEmail`(`userId`);

-- CreateIndex
CREATE INDEX `AuthChangeEmail_email_idx` ON `AuthChangeEmail`(`email`);

-- CreateIndex
CREATE INDEX `Message_createdAt_idx` ON `Message`(`createdAt`);

-- CreateIndex
CREATE INDEX `Notification_createdAt_idx` ON `Notification`(`createdAt`);

-- CreateIndex
CREATE INDEX `NotificationSettings_profileId_idx` ON `NotificationSettings`(`profileId`);

-- CreateIndex
CREATE INDEX `Post_createdAt_idx` ON `Post`(`createdAt`);

-- CreateIndex
CREATE INDEX `Profile_createdAt_idx` ON `Profile`(`createdAt`);

-- CreateIndex
CREATE INDEX `ProfileSettings_profileId_idx` ON `ProfileSettings`(`profileId`);

-- CreateIndex
CREATE INDEX `UserSettings_userId_idx` ON `UserSettings`(`userId`);

-- RenameIndex
ALTER TABLE `List` RENAME INDEX `List_profileId_fkey` TO `List_profileId_idx`;

-- RenameIndex
ALTER TABLE `Notification` RENAME INDEX `Notification_profileId_fkey` TO `Notification_profileId_idx`;

-- RenameIndex
ALTER TABLE `ProfileWebPush` RENAME INDEX `ProfileWebPush_profileId_fkey` TO `ProfileWebPush_profileId_idx`;
