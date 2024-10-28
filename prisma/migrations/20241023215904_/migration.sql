-- CreateTable
CREATE TABLE `AuthVerificationIP` (
    `identifier` VARCHAR(191) NOT NULL,
    `ip` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `AuthVerificationIP_identifier_key`(`identifier`)
);