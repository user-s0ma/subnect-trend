-- AddForeignKey
ALTER TABLE `Subscription` ADD CONSTRAINT `Subscription_profileId_fkey` FOREIGN KEY (`profileId`) REFERENCES `Profile`(`profileId`) ON DELETE CASCADE ON UPDATE CASCADE;
