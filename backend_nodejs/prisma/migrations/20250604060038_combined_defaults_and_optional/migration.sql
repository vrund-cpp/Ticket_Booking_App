/*
  Warnings:

  - You are about to drop the column `subtitle` on the `Attraction` table. All the data in the column will be lost.
  - You are about to drop the column `title` on the `Attraction` table. All the data in the column will be lost.
  - You are about to drop the column `releaseDate` on the `Movie` table. All the data in the column will be lost.
  - You are about to drop the column `content` on the `News` table. All the data in the column will be lost.
  - You are about to drop the column `createdAt` on the `News` table. All the data in the column will be lost.
  - You are about to drop the column `userId` on the `Notification` table. All the data in the column will be lost.
  - You are about to drop the column `createdAt` on the `OutreachProgram` table. All the data in the column will be lost.
  - You are about to drop the column `description` on the `OutreachProgram` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "Attraction" DROP COLUMN "subtitle",
DROP COLUMN "title",
ADD COLUMN     "description" TEXT,
ADD COLUMN     "imageUrl" TEXT,
ADD COLUMN     "name" TEXT;

-- AlterTable
ALTER TABLE "Movie" DROP COLUMN "releaseDate",
ADD COLUMN     "summary" TEXT NOT NULL DEFAULT 'No summary available.';

-- AlterTable
ALTER TABLE "News" DROP COLUMN "content",
DROP COLUMN "createdAt",
ADD COLUMN     "date" TIMESTAMP(3),
ADD COLUMN     "description" TEXT;

-- AlterTable
ALTER TABLE "Notification" DROP COLUMN "userId";

-- AlterTable
ALTER TABLE "OutreachProgram" DROP COLUMN "createdAt",
DROP COLUMN "description",
ADD COLUMN     "details" TEXT,
ADD COLUMN     "endDate" TIMESTAMP(3),
ADD COLUMN     "startDate" TIMESTAMP(3);

-- CreateTable
CREATE TABLE "Entry" (
    "id" SERIAL NOT NULL,
    "title" TEXT NOT NULL,
    "icon" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Entry_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Parking" (
    "id" SERIAL NOT NULL,
    "title" TEXT NOT NULL,
    "icon" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Parking_pkey" PRIMARY KEY ("id")
);
