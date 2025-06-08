/*
  Warnings:

  - You are about to drop the column `label` on the `category` table. All the data in the column will be lost.
  - You are about to drop the column `value` on the `category` table. All the data in the column will be lost.
  - You are about to drop the column `createDate` on the `comment` table. All the data in the column will be lost.
  - You are about to drop the column `categoryId` on the `post` table. All the data in the column will be lost.
  - You are about to drop the column `createDate` on the `post` table. All the data in the column will be lost.
  - You are about to drop the column `image` on the `post` table. All the data in the column will be lost.
  - You are about to drop the column `lastModifyDate` on the `post` table. All the data in the column will be lost.
  - You are about to drop the column `slug` on the `post` table. All the data in the column will be lost.
  - You are about to drop the column `aboutMe` on the `user` table. All the data in the column will be lost.
  - You are about to drop the column `birthDate` on the `user` table. All the data in the column will be lost.
  - You are about to drop the column `image` on the `user` table. All the data in the column will be lost.
  - You are about to drop the column `registerDate` on the `user` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[name]` on the table `Category` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `name` to the `Category` table without a default value. This is not possible if the table is not empty.
  - Made the column `name` on table `user` required. This step will fail if there are existing NULL values in that column.

*/
-- DropForeignKey
ALTER TABLE `comment` DROP FOREIGN KEY `Comment_authorId_fkey`;

-- DropForeignKey
ALTER TABLE `comment` DROP FOREIGN KEY `Comment_postId_fkey`;

-- DropForeignKey
ALTER TABLE `post` DROP FOREIGN KEY `Post_authorId_fkey`;

-- DropForeignKey
ALTER TABLE `post` DROP FOREIGN KEY `Post_categoryId_fkey`;

-- DropIndex
DROP INDEX `Category_value_key` ON `category`;

-- DropIndex
DROP INDEX `Comment_authorId_fkey` ON `comment`;

-- DropIndex
DROP INDEX `Comment_postId_fkey` ON `comment`;

-- DropIndex
DROP INDEX `Post_authorId_fkey` ON `post`;

-- DropIndex
DROP INDEX `Post_categoryId_fkey` ON `post`;

-- DropIndex
DROP INDEX `Post_slug_key` ON `post`;

-- AlterTable
ALTER TABLE `category` DROP COLUMN `label`,
    DROP COLUMN `value`,
    ADD COLUMN `name` VARCHAR(191) NOT NULL;

-- AlterTable
ALTER TABLE `comment` DROP COLUMN `createDate`,
    ADD COLUMN `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3);

-- AlterTable
ALTER TABLE `post` DROP COLUMN `categoryId`,
    DROP COLUMN `createDate`,
    DROP COLUMN `image`,
    DROP COLUMN `lastModifyDate`,
    DROP COLUMN `slug`,
    ADD COLUMN `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    ADD COLUMN `published` BOOLEAN NOT NULL DEFAULT false,
    MODIFY `content` VARCHAR(191) NOT NULL;

-- AlterTable
ALTER TABLE `user` DROP COLUMN `aboutMe`,
    DROP COLUMN `birthDate`,
    DROP COLUMN `image`,
    DROP COLUMN `registerDate`,
    ADD COLUMN `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    MODIFY `name` VARCHAR(191) NOT NULL;

-- CreateTable
CREATE TABLE `PostCategory` (
    `postId` INTEGER NOT NULL,
    `categoryId` INTEGER NOT NULL,

    PRIMARY KEY (`postId`, `categoryId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateIndex
CREATE UNIQUE INDEX `Category_name_key` ON `Category`(`name`);

-- AddForeignKey
ALTER TABLE `Post` ADD CONSTRAINT `Post_authorId_fkey` FOREIGN KEY (`authorId`) REFERENCES `User`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Comment` ADD CONSTRAINT `Comment_postId_fkey` FOREIGN KEY (`postId`) REFERENCES `Post`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Comment` ADD CONSTRAINT `Comment_authorId_fkey` FOREIGN KEY (`authorId`) REFERENCES `User`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `PostCategory` ADD CONSTRAINT `PostCategory_postId_fkey` FOREIGN KEY (`postId`) REFERENCES `Post`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `PostCategory` ADD CONSTRAINT `PostCategory_categoryId_fkey` FOREIGN KEY (`categoryId`) REFERENCES `Category`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
