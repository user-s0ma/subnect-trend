-- AlterTable
ALTER TABLE `NotificationSettings` ADD COLUMN `appMentions` BOOLEAN NOT NULL DEFAULT true,
    ADD COLUMN `pushMentions` BOOLEAN NOT NULL DEFAULT true;

-- CreateTable
CREATE TABLE `PostTrend` (
    `id` VARCHAR(191) NOT NULL,
    `word` VARCHAR(191) NOT NULL,
    `nextWord` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `PostTrend_word_idx`(`word`),
    INDEX `PostTrend_word_nextWord_idx`(`word`, `nextWord`),
    PRIMARY KEY (`id`)
);

-- CreateTable
CREATE TABLE `MessageHidden` (
    `hiddenId` VARCHAR(191) NOT NULL,
    `senderId` VARCHAR(191) NOT NULL,
    `receiverId` VARCHAR(191) NOT NULL,
    `replyToId` VARCHAR(191) NULL,

    INDEX `MessageHidden_senderId_idx`(`senderId`),
    INDEX `MessageHidden_receiverId_idx`(`receiverId`),
    PRIMARY KEY (`hiddenId`)
);

-- AddForeignKey
ALTER TABLE `MessageHidden` ADD CONSTRAINT `MessageHidden_senderId_fkey` FOREIGN KEY (`senderId`) REFERENCES `Profile`(`profileId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `MessageHidden` ADD CONSTRAINT `MessageHidden_receiverId_fkey` FOREIGN KEY (`receiverId`) REFERENCES `Profile`(`profileId`) ON DELETE CASCADE ON UPDATE CASCADE;
