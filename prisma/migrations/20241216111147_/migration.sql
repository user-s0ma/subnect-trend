-- CreateTable
CREATE TABLE `AuthUser` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NULL,
    `email` VARCHAR(191) NOT NULL,
    `emailVerified` DATETIME(3) NULL,
    `image` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,
    `admin` BOOLEAN NOT NULL DEFAULT false,

    UNIQUE INDEX `AuthUser_email_key`(`email`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `AuthAccount` (
    `userId` VARCHAR(191) NOT NULL,
    `type` VARCHAR(191) NOT NULL,
    `provider` VARCHAR(191) NOT NULL,
    `providerAccountId` VARCHAR(191) NOT NULL,
    `refresh_token` TEXT NULL,
    `access_token` TEXT NULL,
    `expires_at` INTEGER NULL,
    `token_type` VARCHAR(191) NULL,
    `scope` VARCHAR(191) NULL,
    `id_token` TEXT NULL,
    `session_state` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`provider`, `providerAccountId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `AuthSession` (
    `sessionId` VARCHAR(191) NOT NULL,
    `sessionToken` VARCHAR(191) NOT NULL,
    `userId` VARCHAR(191) NOT NULL,
    `expires` DATETIME(3) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,
    `ip` VARCHAR(191) NOT NULL,
    `country` VARCHAR(191) NULL,
    `region` VARCHAR(191) NULL,
    `city` VARCHAR(191) NULL,
    `latitude` DOUBLE NULL,
    `longitude` DOUBLE NULL,
    `userAgent` VARCHAR(191) NOT NULL,
    `deviceType` VARCHAR(191) NULL,
    `browser` VARCHAR(191) NULL,
    `deletedAt` DATETIME(3) NULL,

    UNIQUE INDEX `AuthSession_sessionToken_key`(`sessionToken`),
    PRIMARY KEY (`sessionId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `AuthVerificationToken` (
    `identifier` VARCHAR(191) NOT NULL,
    `token` VARCHAR(191) NOT NULL,
    `expires` DATETIME(3) NOT NULL,

    PRIMARY KEY (`identifier`, `token`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `AuthAuthenticator` (
    `id` VARCHAR(191) NOT NULL,
    `credentialID` VARCHAR(191) NOT NULL,
    `userId` VARCHAR(191) NOT NULL,
    `providerAccountId` VARCHAR(191) NOT NULL,
    `credentialPublicKey` VARCHAR(191) NOT NULL,
    `counter` INTEGER NOT NULL,
    `credentialDeviceType` VARCHAR(191) NOT NULL,
    `credentialBackedUp` BOOLEAN NOT NULL,
    `transports` VARCHAR(191) NULL,

    UNIQUE INDEX `AuthAuthenticator_credentialID_key`(`credentialID`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `AuthChangeEmail` (
    `userId` VARCHAR(191) NOT NULL,
    `email` VARCHAR(191) NOT NULL,
    `code` VARCHAR(191) NOT NULL,
    `expiresAt` DATETIME(3) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    UNIQUE INDEX `AuthChangeEmail_userId_key`(`userId`),
    INDEX `AuthChangeEmail_userId_idx`(`userId`),
    INDEX `AuthChangeEmail_email_idx`(`email`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `AuthBanIP` (
    `banId` VARCHAR(191) NOT NULL,
    `ip` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    UNIQUE INDEX `AuthBanIP_ip_key`(`ip`),
    INDEX `AuthBanIP_ip_idx`(`ip`),
    PRIMARY KEY (`banId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `AuthBanEmail` (
    `banId` VARCHAR(191) NOT NULL,
    `email` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    UNIQUE INDEX `AuthBanEmail_email_key`(`email`),
    INDEX `AuthBanEmail_email_idx`(`email`),
    PRIMARY KEY (`banId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `UserSettings` (
    `userId` VARCHAR(191) NOT NULL,
    `language` VARCHAR(191) NULL,
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `UserSettings_userId_key`(`userId`),
    INDEX `UserSettings_userId_idx`(`userId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Profile` (
    `profileId` VARCHAR(191) NOT NULL,
    `userId` VARCHAR(191) NOT NULL,
    `username` VARCHAR(191) NOT NULL,
    `nickname` VARCHAR(191) NOT NULL DEFAULT 'New user',
    `iconId` VARCHAR(191) NOT NULL,
    `headerId` VARCHAR(191) NULL,
    `bio` TEXT NULL,
    `pinnedPostId` VARCHAR(191) NULL,
    `followingCount` INTEGER NOT NULL DEFAULT 0,
    `followersCount` INTEGER NOT NULL DEFAULT 0,
    `hidden` BOOLEAN NOT NULL DEFAULT false,
    `banned` BOOLEAN NOT NULL DEFAULT false,
    `official` BOOLEAN NOT NULL DEFAULT false,
    `deletedAt` DATETIME(3) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    UNIQUE INDEX `Profile_username_key`(`username`),
    INDEX `Profile_profileId_idx`(`profileId`),
    INDEX `Profile_username_idx`(`username`),
    INDEX `Profile_createdAt_idx`(`createdAt`),
    PRIMARY KEY (`profileId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Subscription` (
    `subscriptionId` VARCHAR(191) NOT NULL,
    `profileId` VARCHAR(191) NOT NULL,
    `stripeSubscriptionId` VARCHAR(191) NOT NULL,
    `stripeCustomerId` VARCHAR(191) NOT NULL,
    `planName` VARCHAR(191) NOT NULL,
    `currentPeriodEnd` DATETIME(3) NOT NULL,
    `status` VARCHAR(191) NOT NULL,
    `cancelAtPeriodEnd` BOOLEAN NOT NULL DEFAULT false,
    `updatedAt` DATETIME(3) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    UNIQUE INDEX `Subscription_profileId_key`(`profileId`),
    UNIQUE INDEX `Subscription_stripeSubscriptionId_key`(`stripeSubscriptionId`),
    PRIMARY KEY (`subscriptionId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ProfileSettings` (
    `profileId` VARCHAR(191) NOT NULL,
    `darkMode` BOOLEAN NOT NULL DEFAULT false,
    `customColor` BOOLEAN NOT NULL DEFAULT false,
    `backColor` VARCHAR(191) NOT NULL DEFAULT 'E6E6E6',
    `borderColor` VARCHAR(191) NOT NULL DEFAULT '808080',
    `accentColor` VARCHAR(191) NOT NULL DEFAULT '000000',
    `fontColor` VARCHAR(191) NOT NULL DEFAULT '000000',
    `messagesFollowingOnly` BOOLEAN NOT NULL DEFAULT false,
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `ProfileSettings_profileId_key`(`profileId`),
    INDEX `ProfileSettings_profileId_idx`(`profileId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Asset` (
    `assetId` VARCHAR(191) NOT NULL,
    `profileId` VARCHAR(191) NULL,
    `public` BOOLEAN NOT NULL DEFAULT true,
    `assetName` VARCHAR(191) NOT NULL,
    `assetSize` INTEGER NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `Asset_profileId_idx`(`profileId`),
    PRIMARY KEY (`assetId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `AssetImage` (
    `assetId` VARCHAR(191) NOT NULL,
    `alt` VARCHAR(191) NULL,
    `aspect` DOUBLE NOT NULL,
    `spoiler` BOOLEAN NOT NULL DEFAULT false,

    UNIQUE INDEX `AssetImage_assetId_key`(`assetId`),
    INDEX `AssetImage_assetId_idx`(`assetId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `AssetVideo` (
    `assetId` VARCHAR(191) NOT NULL,
    `spoiler` BOOLEAN NOT NULL DEFAULT false,

    UNIQUE INDEX `AssetVideo_assetId_key`(`assetId`),
    INDEX `AssetVideo_assetId_idx`(`assetId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Notification` (
    `notificationId` VARCHAR(191) NOT NULL,
    `profileId` VARCHAR(191) NOT NULL,
    `appView` BOOLEAN NOT NULL DEFAULT true,
    `type` VARCHAR(191) NOT NULL,
    `senderId` VARCHAR(191) NOT NULL,
    `postId` VARCHAR(191) NULL,
    `readAt` DATETIME(3) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `Notification_profileId_idx`(`profileId`),
    INDEX `Notification_createdAt_idx`(`createdAt`),
    PRIMARY KEY (`notificationId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `NotificationSettings` (
    `profileId` VARCHAR(191) NOT NULL,
    `pushReactions` BOOLEAN NOT NULL DEFAULT true,
    `pushReplies` BOOLEAN NOT NULL DEFAULT true,
    `pushMentions` BOOLEAN NOT NULL DEFAULT true,
    `pushReposts` BOOLEAN NOT NULL DEFAULT true,
    `pushQuotes` BOOLEAN NOT NULL DEFAULT true,
    `pushFollows` BOOLEAN NOT NULL DEFAULT true,
    `pushMessages` BOOLEAN NOT NULL DEFAULT true,
    `appReactions` BOOLEAN NOT NULL DEFAULT true,
    `appReplies` BOOLEAN NOT NULL DEFAULT true,
    `appMentions` BOOLEAN NOT NULL DEFAULT true,
    `appReposts` BOOLEAN NOT NULL DEFAULT true,
    `appQuotes` BOOLEAN NOT NULL DEFAULT true,
    `appFollows` BOOLEAN NOT NULL DEFAULT true,

    UNIQUE INDEX `NotificationSettings_profileId_key`(`profileId`),
    INDEX `NotificationSettings_profileId_idx`(`profileId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ProfileWebPush` (
    `pushId` VARCHAR(191) NOT NULL,
    `profileId` VARCHAR(191) NOT NULL,
    `endpoint` TEXT NOT NULL,
    `keys` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `ProfileWebPush_profileId_idx`(`profileId`),
    PRIMARY KEY (`pushId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Follow` (
    `followId` VARCHAR(191) NOT NULL,
    `profileId` VARCHAR(191) NOT NULL,
    `followerId` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `Follow_profileId_idx`(`profileId`),
    INDEX `Follow_followerId_idx`(`followerId`),
    UNIQUE INDEX `Follow_profileId_followerId_key`(`profileId`, `followerId`),
    PRIMARY KEY (`followId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Block` (
    `blockId` VARCHAR(191) NOT NULL,
    `profileId` VARCHAR(191) NOT NULL,
    `blockedId` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `Block_profileId_idx`(`profileId`),
    INDEX `Block_blockedId_idx`(`blockedId`),
    UNIQUE INDEX `Block_profileId_blockedId_key`(`profileId`, `blockedId`),
    PRIMARY KEY (`blockId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `List` (
    `listId` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `description` TEXT NULL,
    `iconId` VARCHAR(191) NOT NULL,
    `profileId` VARCHAR(191) NOT NULL,
    `public` BOOLEAN NOT NULL DEFAULT false,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `List_profileId_idx`(`profileId`),
    PRIMARY KEY (`listId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ListMember` (
    `memberId` VARCHAR(191) NOT NULL,
    `listId` VARCHAR(191) NOT NULL,
    `profileId` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `ListMember_profileId_idx`(`profileId`),
    UNIQUE INDEX `ListMember_listId_profileId_key`(`listId`, `profileId`),
    PRIMARY KEY (`memberId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ListFollow` (
    `followId` VARCHAR(191) NOT NULL,
    `listId` VARCHAR(191) NOT NULL,
    `followerId` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `ListFollow_followerId_idx`(`followerId`),
    UNIQUE INDEX `ListFollow_listId_followerId_key`(`listId`, `followerId`),
    PRIMARY KEY (`followId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Post` (
    `postId` VARCHAR(191) NOT NULL,
    `profileId` VARCHAR(191) NOT NULL,
    `replyToId` VARCHAR(191) NULL,
    `repost` BOOLEAN NOT NULL DEFAULT false,
    `text` TEXT NULL,
    `language` VARCHAR(191) NOT NULL DEFAULT 'en',
    `repliesCount` INTEGER NOT NULL DEFAULT 0,
    `repostCount` INTEGER NOT NULL DEFAULT 0,
    `quoteCount` INTEGER NOT NULL DEFAULT 0,
    `reactionCount` INTEGER NOT NULL DEFAULT 0,
    `likeCount` INTEGER NOT NULL DEFAULT 0,
    `scope` VARCHAR(191) NULL,
    `scopeListId` VARCHAR(191) NULL,
    `violation` BOOLEAN NOT NULL DEFAULT false,
    `edited` BOOLEAN NOT NULL DEFAULT false,
    `scheduledAt` DATETIME(3) NULL,
    `deletedAt` DATETIME(3) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `Post_profileId_idx`(`profileId`),
    INDEX `Post_replyToId_idx`(`replyToId`),
    INDEX `Post_createdAt_idx`(`createdAt`),
    PRIMARY KEY (`postId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `PostEditHistory` (
    `editId` VARCHAR(191) NOT NULL,
    `postId` VARCHAR(191) NOT NULL,
    `text` TEXT NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `PostEditHistory_postId_idx`(`postId`),
    PRIMARY KEY (`editId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `PostAsset` (
    `postId` VARCHAR(191) NOT NULL,
    `assetId` VARCHAR(191) NOT NULL,

    INDEX `PostAsset_postId_idx`(`postId`),
    INDEX `PostAsset_assetId_idx`(`assetId`),
    PRIMARY KEY (`postId`, `assetId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `PostView` (
    `viewId` VARCHAR(191) NOT NULL,
    `profileId` VARCHAR(191) NOT NULL,
    `postId` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `PostView_postId_idx`(`postId`),
    INDEX `PostView_profileId_idx`(`profileId`),
    PRIMARY KEY (`viewId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `PostLike` (
    `likeId` VARCHAR(191) NOT NULL,
    `postId` VARCHAR(191) NOT NULL,
    `profileId` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `PostLike_postId_idx`(`postId`),
    INDEX `PostLike_profileId_idx`(`profileId`),
    UNIQUE INDEX `PostLike_postId_profileId_key`(`postId`, `profileId`),
    PRIMARY KEY (`likeId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `PostReaction` (
    `reactionId` VARCHAR(191) NOT NULL,
    `postId` VARCHAR(191) NOT NULL,
    `profileId` VARCHAR(191) NOT NULL,
    `emoji` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `PostReaction_postId_idx`(`postId`),
    INDEX `PostReaction_profileId_idx`(`profileId`),
    UNIQUE INDEX `PostReaction_postId_profileId_key`(`postId`, `profileId`),
    PRIMARY KEY (`reactionId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `PostQuote` (
    `quoteId` VARCHAR(191) NOT NULL,
    `profileId` VARCHAR(191) NOT NULL,
    `parentId` VARCHAR(191) NOT NULL,
    `embedId` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `PostQuote_parentId_idx`(`parentId`),
    INDEX `PostQuote_embedId_idx`(`embedId`),
    INDEX `PostQuote_profileId_idx`(`profileId`),
    PRIMARY KEY (`quoteId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `PostTrendWord` (
    `wordId` VARCHAR(191) NOT NULL,
    `word` VARCHAR(191) NOT NULL,
    `language` VARCHAR(191) NOT NULL DEFAULT 'en',
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `PostTrendWord_word_idx`(`word`),
    INDEX `PostTrendWord_createdAt_idx`(`createdAt`),
    PRIMARY KEY (`wordId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `PostTrend` (
    `trendId` VARCHAR(191) NOT NULL,
    `word` VARCHAR(191) NOT NULL,
    `postCount` INTEGER NOT NULL DEFAULT 0,
    `language` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `PostTrend_createdAt_idx`(`createdAt`),
    PRIMARY KEY (`trendId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `BookmarkFolder` (
    `folderId` VARCHAR(191) NOT NULL,
    `profileId` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `BookmarkFolder_profileId_idx`(`profileId`),
    PRIMARY KEY (`folderId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Bookmark` (
    `bookmarkId` VARCHAR(191) NOT NULL,
    `postId` VARCHAR(191) NOT NULL,
    `folderId` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `Bookmark_postId_idx`(`postId`),
    INDEX `Bookmark_folderId_idx`(`folderId`),
    UNIQUE INDEX `Bookmark_postId_folderId_key`(`postId`, `folderId`),
    PRIMARY KEY (`bookmarkId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Message` (
    `messageId` VARCHAR(191) NOT NULL,
    `profileId` VARCHAR(191) NOT NULL,
    `receiverId` VARCHAR(191) NOT NULL,
    `replyToId` VARCHAR(191) NULL,
    `text` TEXT NULL,
    `readAt` DATETIME(3) NULL,
    `deletedAt` DATETIME(3) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `Message_profileId_idx`(`profileId`),
    INDEX `Message_receiverId_idx`(`receiverId`),
    INDEX `Message_createdAt_idx`(`createdAt`),
    PRIMARY KEY (`messageId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `MessageReaction` (
    `reactionId` VARCHAR(191) NOT NULL,
    `messageId` VARCHAR(191) NOT NULL,
    `profileId` VARCHAR(191) NOT NULL,
    `emoji` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `MessageReaction_messageId_idx`(`messageId`),
    INDEX `MessageReaction_profileId_idx`(`profileId`),
    UNIQUE INDEX `MessageReaction_messageId_profileId_key`(`messageId`, `profileId`),
    PRIMARY KEY (`reactionId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `MessageAsset` (
    `messageId` VARCHAR(191) NOT NULL,
    `assetId` VARCHAR(191) NOT NULL,

    INDEX `MessageAsset_messageId_idx`(`messageId`),
    INDEX `MessageAsset_assetId_idx`(`assetId`),
    PRIMARY KEY (`messageId`, `assetId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `MessageHidden` (
    `hiddenId` VARCHAR(191) NOT NULL,
    `profileId` VARCHAR(191) NOT NULL,
    `receiverId` VARCHAR(191) NOT NULL,

    INDEX `MessageHidden_profileId_idx`(`profileId`),
    INDEX `MessageHidden_receiverId_idx`(`receiverId`),
    UNIQUE INDEX `MessageHidden_profileId_receiverId_key`(`profileId`, `receiverId`),
    PRIMARY KEY (`hiddenId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Url` (
    `urlId` VARCHAR(191) NOT NULL,
    `url` TEXT NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `Url_urlId_idx`(`urlId`),
    PRIMARY KEY (`urlId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `UrlView` (
    `viewId` VARCHAR(191) NOT NULL,
    `profileId` VARCHAR(191) NULL,
    `urlId` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `UrlView_profileId_idx`(`profileId`),
    INDEX `UrlView_urlId_idx`(`urlId`),
    INDEX `UrlView_createdAt_idx`(`createdAt`),
    PRIMARY KEY (`viewId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `AdPost` (
    `adId` VARCHAR(191) NOT NULL,
    `profileId` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `postId` VARCHAR(191) NOT NULL,
    `urlId` VARCHAR(191) NULL,
    `budget` DOUBLE NOT NULL,
    `startDate` DATETIME(3) NOT NULL,
    `endDate` DATETIME(3) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `AdPost_profileId_idx`(`profileId`),
    INDEX `AdPost_postId_idx`(`postId`),
    PRIMARY KEY (`adId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `AdPostRead` (
    `readId` VARCHAR(191) NOT NULL,
    `profileId` VARCHAR(191) NULL,
    `adId` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `AdPostRead_profileId_idx`(`profileId`),
    INDEX `AdPostRead_createdAt_idx`(`createdAt`),
    PRIMARY KEY (`readId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ReportProfile` (
    `reportId` VARCHAR(191) NOT NULL,
    `profileId` VARCHAR(191) NOT NULL,
    `reportedId` VARCHAR(191) NOT NULL,
    `category` VARCHAR(191) NULL,
    `reason` TEXT NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `ReportProfile_profileId_idx`(`profileId`),
    INDEX `ReportProfile_reportedId_idx`(`reportedId`),
    PRIMARY KEY (`reportId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ReportPost` (
    `reportId` VARCHAR(191) NOT NULL,
    `profileId` VARCHAR(191) NOT NULL,
    `postId` VARCHAR(191) NOT NULL,
    `category` VARCHAR(191) NULL,
    `reason` TEXT NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `ReportPost_profileId_idx`(`profileId`),
    INDEX `ReportPost_postId_idx`(`postId`),
    PRIMARY KEY (`reportId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `AdminLog` (
    `logId` VARCHAR(191) NOT NULL,
    `userId` VARCHAR(191) NOT NULL,
    `log` TEXT NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `AdminLog_userId_idx`(`userId`),
    INDEX `AdminLog_createdAt_idx`(`createdAt`),
    PRIMARY KEY (`logId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `AuthAccount` ADD CONSTRAINT `AuthAccount_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `AuthUser`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `AuthSession` ADD CONSTRAINT `AuthSession_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `AuthUser`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `AuthAuthenticator` ADD CONSTRAINT `AuthAuthenticator_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `AuthUser`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `AuthChangeEmail` ADD CONSTRAINT `AuthChangeEmail_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `AuthUser`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `UserSettings` ADD CONSTRAINT `UserSettings_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `AuthUser`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Profile` ADD CONSTRAINT `Profile_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `AuthUser`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Profile` ADD CONSTRAINT `Profile_iconId_fkey` FOREIGN KEY (`iconId`) REFERENCES `Asset`(`assetId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Profile` ADD CONSTRAINT `Profile_headerId_fkey` FOREIGN KEY (`headerId`) REFERENCES `Asset`(`assetId`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Profile` ADD CONSTRAINT `Profile_pinnedPostId_fkey` FOREIGN KEY (`pinnedPostId`) REFERENCES `Post`(`postId`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Subscription` ADD CONSTRAINT `Subscription_profileId_fkey` FOREIGN KEY (`profileId`) REFERENCES `Profile`(`profileId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ProfileSettings` ADD CONSTRAINT `ProfileSettings_profileId_fkey` FOREIGN KEY (`profileId`) REFERENCES `Profile`(`profileId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Asset` ADD CONSTRAINT `Asset_profileId_fkey` FOREIGN KEY (`profileId`) REFERENCES `Profile`(`profileId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `AssetImage` ADD CONSTRAINT `AssetImage_assetId_fkey` FOREIGN KEY (`assetId`) REFERENCES `Asset`(`assetId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `AssetVideo` ADD CONSTRAINT `AssetVideo_assetId_fkey` FOREIGN KEY (`assetId`) REFERENCES `Asset`(`assetId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Notification` ADD CONSTRAINT `Notification_profileId_fkey` FOREIGN KEY (`profileId`) REFERENCES `Profile`(`profileId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Notification` ADD CONSTRAINT `Notification_senderId_fkey` FOREIGN KEY (`senderId`) REFERENCES `Profile`(`profileId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Notification` ADD CONSTRAINT `Notification_postId_fkey` FOREIGN KEY (`postId`) REFERENCES `Post`(`postId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `NotificationSettings` ADD CONSTRAINT `NotificationSettings_profileId_fkey` FOREIGN KEY (`profileId`) REFERENCES `Profile`(`profileId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ProfileWebPush` ADD CONSTRAINT `ProfileWebPush_profileId_fkey` FOREIGN KEY (`profileId`) REFERENCES `Profile`(`profileId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Follow` ADD CONSTRAINT `Follow_profileId_fkey` FOREIGN KEY (`profileId`) REFERENCES `Profile`(`profileId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Follow` ADD CONSTRAINT `Follow_followerId_fkey` FOREIGN KEY (`followerId`) REFERENCES `Profile`(`profileId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Block` ADD CONSTRAINT `Block_profileId_fkey` FOREIGN KEY (`profileId`) REFERENCES `Profile`(`profileId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Block` ADD CONSTRAINT `Block_blockedId_fkey` FOREIGN KEY (`blockedId`) REFERENCES `Profile`(`profileId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `List` ADD CONSTRAINT `List_iconId_fkey` FOREIGN KEY (`iconId`) REFERENCES `Asset`(`assetId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `List` ADD CONSTRAINT `List_profileId_fkey` FOREIGN KEY (`profileId`) REFERENCES `Profile`(`profileId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ListMember` ADD CONSTRAINT `ListMember_listId_fkey` FOREIGN KEY (`listId`) REFERENCES `List`(`listId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ListMember` ADD CONSTRAINT `ListMember_profileId_fkey` FOREIGN KEY (`profileId`) REFERENCES `Profile`(`profileId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ListFollow` ADD CONSTRAINT `ListFollow_listId_fkey` FOREIGN KEY (`listId`) REFERENCES `List`(`listId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ListFollow` ADD CONSTRAINT `ListFollow_followerId_fkey` FOREIGN KEY (`followerId`) REFERENCES `Profile`(`profileId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Post` ADD CONSTRAINT `Post_profileId_fkey` FOREIGN KEY (`profileId`) REFERENCES `Profile`(`profileId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Post` ADD CONSTRAINT `Post_replyToId_fkey` FOREIGN KEY (`replyToId`) REFERENCES `Post`(`postId`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Post` ADD CONSTRAINT `Post_scopeListId_fkey` FOREIGN KEY (`scopeListId`) REFERENCES `List`(`listId`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `PostEditHistory` ADD CONSTRAINT `PostEditHistory_postId_fkey` FOREIGN KEY (`postId`) REFERENCES `Post`(`postId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `PostAsset` ADD CONSTRAINT `PostAsset_postId_fkey` FOREIGN KEY (`postId`) REFERENCES `Post`(`postId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `PostAsset` ADD CONSTRAINT `PostAsset_assetId_fkey` FOREIGN KEY (`assetId`) REFERENCES `Asset`(`assetId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `PostView` ADD CONSTRAINT `PostView_profileId_fkey` FOREIGN KEY (`profileId`) REFERENCES `Profile`(`profileId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `PostView` ADD CONSTRAINT `PostView_postId_fkey` FOREIGN KEY (`postId`) REFERENCES `Post`(`postId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `PostLike` ADD CONSTRAINT `PostLike_postId_fkey` FOREIGN KEY (`postId`) REFERENCES `Post`(`postId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `PostLike` ADD CONSTRAINT `PostLike_profileId_fkey` FOREIGN KEY (`profileId`) REFERENCES `Profile`(`profileId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `PostReaction` ADD CONSTRAINT `PostReaction_postId_fkey` FOREIGN KEY (`postId`) REFERENCES `Post`(`postId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `PostReaction` ADD CONSTRAINT `PostReaction_profileId_fkey` FOREIGN KEY (`profileId`) REFERENCES `Profile`(`profileId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `PostQuote` ADD CONSTRAINT `PostQuote_profileId_fkey` FOREIGN KEY (`profileId`) REFERENCES `Profile`(`profileId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `PostQuote` ADD CONSTRAINT `PostQuote_parentId_fkey` FOREIGN KEY (`parentId`) REFERENCES `Post`(`postId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `PostQuote` ADD CONSTRAINT `PostQuote_embedId_fkey` FOREIGN KEY (`embedId`) REFERENCES `Post`(`postId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `BookmarkFolder` ADD CONSTRAINT `BookmarkFolder_profileId_fkey` FOREIGN KEY (`profileId`) REFERENCES `Profile`(`profileId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Bookmark` ADD CONSTRAINT `Bookmark_postId_fkey` FOREIGN KEY (`postId`) REFERENCES `Post`(`postId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Bookmark` ADD CONSTRAINT `Bookmark_folderId_fkey` FOREIGN KEY (`folderId`) REFERENCES `BookmarkFolder`(`folderId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Message` ADD CONSTRAINT `Message_profileId_fkey` FOREIGN KEY (`profileId`) REFERENCES `Profile`(`profileId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Message` ADD CONSTRAINT `Message_receiverId_fkey` FOREIGN KEY (`receiverId`) REFERENCES `Profile`(`profileId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Message` ADD CONSTRAINT `Message_replyToId_fkey` FOREIGN KEY (`replyToId`) REFERENCES `Message`(`messageId`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `MessageReaction` ADD CONSTRAINT `MessageReaction_messageId_fkey` FOREIGN KEY (`messageId`) REFERENCES `Message`(`messageId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `MessageReaction` ADD CONSTRAINT `MessageReaction_profileId_fkey` FOREIGN KEY (`profileId`) REFERENCES `Profile`(`profileId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `MessageAsset` ADD CONSTRAINT `MessageAsset_messageId_fkey` FOREIGN KEY (`messageId`) REFERENCES `Message`(`messageId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `MessageAsset` ADD CONSTRAINT `MessageAsset_assetId_fkey` FOREIGN KEY (`assetId`) REFERENCES `Asset`(`assetId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `MessageHidden` ADD CONSTRAINT `MessageHidden_profileId_fkey` FOREIGN KEY (`profileId`) REFERENCES `Profile`(`profileId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `MessageHidden` ADD CONSTRAINT `MessageHidden_receiverId_fkey` FOREIGN KEY (`receiverId`) REFERENCES `Profile`(`profileId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `UrlView` ADD CONSTRAINT `UrlView_profileId_fkey` FOREIGN KEY (`profileId`) REFERENCES `Profile`(`profileId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `UrlView` ADD CONSTRAINT `UrlView_urlId_fkey` FOREIGN KEY (`urlId`) REFERENCES `Url`(`urlId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `AdPost` ADD CONSTRAINT `AdPost_profileId_fkey` FOREIGN KEY (`profileId`) REFERENCES `Profile`(`profileId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `AdPost` ADD CONSTRAINT `AdPost_postId_fkey` FOREIGN KEY (`postId`) REFERENCES `Post`(`postId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `AdPost` ADD CONSTRAINT `AdPost_urlId_fkey` FOREIGN KEY (`urlId`) REFERENCES `Url`(`urlId`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `AdPostRead` ADD CONSTRAINT `AdPostRead_profileId_fkey` FOREIGN KEY (`profileId`) REFERENCES `Profile`(`profileId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `AdPostRead` ADD CONSTRAINT `AdPostRead_adId_fkey` FOREIGN KEY (`adId`) REFERENCES `AdPost`(`adId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ReportProfile` ADD CONSTRAINT `ReportProfile_profileId_fkey` FOREIGN KEY (`profileId`) REFERENCES `Profile`(`profileId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ReportProfile` ADD CONSTRAINT `ReportProfile_reportedId_fkey` FOREIGN KEY (`reportedId`) REFERENCES `Profile`(`profileId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ReportPost` ADD CONSTRAINT `ReportPost_profileId_fkey` FOREIGN KEY (`profileId`) REFERENCES `Profile`(`profileId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ReportPost` ADD CONSTRAINT `ReportPost_postId_fkey` FOREIGN KEY (`postId`) REFERENCES `Post`(`postId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `AdminLog` ADD CONSTRAINT `AdminLog_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `AuthUser`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
