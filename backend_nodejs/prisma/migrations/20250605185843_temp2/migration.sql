/*
  Warnings:

  - You are about to drop the column `details` on the `Attraction` table. All the data in the column will be lost.
  - You are about to drop the column `name` on the `Attraction` table. All the data in the column will be lost.
  - You are about to drop the column `price` on the `Attraction` table. All the data in the column will be lost.
  - You are about to drop the column `description` on the `Movie` table. All the data in the column will be lost.
  - You are about to drop the column `summary` on the `Movie` table. All the data in the column will be lost.
  - You are about to drop the column `headline` on the `News` table. All the data in the column will be lost.
  - You are about to drop the column `published` on the `News` table. All the data in the column will be lost.
  - You are about to drop the `OutreachProgram` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "Notification" DROP CONSTRAINT "Notification_userId_fkey";

-- AlterTable
ALTER TABLE "Attraction" DROP COLUMN "details",
DROP COLUMN "name",
DROP COLUMN "price",
ADD COLUMN     "description" TEXT,
ADD COLUMN     "title" TEXT;

-- AlterTable
ALTER TABLE "Movie" DROP COLUMN "description",
DROP COLUMN "summary",
ADD COLUMN     "releaseDate" TIMESTAMP(3),
ADD COLUMN     "subtitle" TEXT NOT NULL DEFAULT 'No summary available.';

-- AlterTable
ALTER TABLE "News" DROP COLUMN "headline",
DROP COLUMN "published",
ADD COLUMN     "date" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "title" TEXT;

-- DropTable
DROP TABLE "OutreachProgram";

-- CreateTable
CREATE TABLE "BookingOption" (
    "id" SERIAL NOT NULL,
    "title" TEXT NOT NULL,
    "iconUrl" TEXT NOT NULL,
    "color" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "BookingOption_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "QuickBookingItem" (
    "id" SERIAL NOT NULL,
    "type" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "iconUrl" TEXT NOT NULL,
    "colorHex" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "QuickBookingItem_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Outreach" (
    "id" SERIAL NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT,
    "imageUrl" TEXT NOT NULL,
    "dateStart" TIMESTAMP(3),
    "dateEnd" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Outreach_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "Notification" ADD CONSTRAINT "Notification_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
