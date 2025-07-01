/*
  Warnings:

  - The primary key for the `News` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `Outreach` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - Made the column `title` on table `Attraction` required. This step will fail if there are existing NULL values in that column.

*/
-- CreateEnum
CREATE TYPE "UserType" AS ENUM ('adult', 'kid', 'school');

-- CreateEnum
CREATE TYPE "VehicleType" AS ENUM ('two_wheeler', 'four_wheeler', 'school_bus');

-- CreateEnum
CREATE TYPE "Format" AS ENUM ('two_d', 'three_d');

-- CreateEnum
CREATE TYPE "BookingItemType" AS ENUM ('entry_ticket', 'parking', 'attraction', 'movie');

-- AlterTable
ALTER TABLE "Attraction" ADD COLUMN     "priceAdult" DOUBLE PRECISION NOT NULL DEFAULT 0.0,
ADD COLUMN     "priceKid" DOUBLE PRECISION NOT NULL DEFAULT 0.0,
ADD COLUMN     "priceSchool" DOUBLE PRECISION NOT NULL DEFAULT 0.0,
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ALTER COLUMN "description" DROP NOT NULL,
ALTER COLUMN "title" SET NOT NULL;

-- AlterTable
ALTER TABLE "Movie" ADD COLUMN     "duration" INTEGER NOT NULL DEFAULT 0,
ADD COLUMN     "format" "Format",
ADD COLUMN     "language" TEXT,
ADD COLUMN     "priceAdult" DOUBLE PRECISION NOT NULL DEFAULT 0.0,
ADD COLUMN     "priceKid" DOUBLE PRECISION NOT NULL DEFAULT 0.0,
ADD COLUMN     "priceSchool" DOUBLE PRECISION NOT NULL DEFAULT 0.0,
ADD COLUMN     "timeSlot" TEXT,
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ALTER COLUMN "description" DROP NOT NULL;

-- AlterTable
ALTER TABLE "News" DROP CONSTRAINT "News_pkey",
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ADD CONSTRAINT "News_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "News_id_seq";

-- AlterTable
ALTER TABLE "Outreach" DROP CONSTRAINT "Outreach_pkey",
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ADD CONSTRAINT "Outreach_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "Outreach_id_seq";

-- AlterTable
ALTER TABLE "User" ADD COLUMN     "userType" "UserType";

-- CreateTable
CREATE TABLE "Booking" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "totalPrice" DOUBLE PRECISION NOT NULL DEFAULT 0.0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Booking_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BookingItem" (
    "id" TEXT NOT NULL,
    "bookingId" TEXT NOT NULL,
    "type" "BookingItemType" NOT NULL,
    "quantity" INTEGER NOT NULL,
    "pricePerUnit" DOUBLE PRECISION NOT NULL,
    "entryTicketId" TEXT,
    "parkingId" TEXT,
    "attractionId" INTEGER,
    "movieId" INTEGER,

    CONSTRAINT "BookingItem_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "EntryTicket" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT DEFAULT 'no description available',
    "price" DOUBLE PRECISION NOT NULL,
    "slotCount" INTEGER NOT NULL DEFAULT 0,
    "iconUrl" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "EntryTicket_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ParkingOption" (
    "id" TEXT NOT NULL,
    "vehicleType" "VehicleType" NOT NULL,
    "price" DOUBLE PRECISION NOT NULL,
    "slotCount" INTEGER NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "ParkingOption_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "Booking" ADD CONSTRAINT "Booking_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BookingItem" ADD CONSTRAINT "BookingItem_bookingId_fkey" FOREIGN KEY ("bookingId") REFERENCES "Booking"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BookingItem" ADD CONSTRAINT "BookingItem_entryTicketId_fkey" FOREIGN KEY ("entryTicketId") REFERENCES "EntryTicket"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BookingItem" ADD CONSTRAINT "BookingItem_parkingId_fkey" FOREIGN KEY ("parkingId") REFERENCES "ParkingOption"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BookingItem" ADD CONSTRAINT "BookingItem_attractionId_fkey" FOREIGN KEY ("attractionId") REFERENCES "Attraction"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BookingItem" ADD CONSTRAINT "BookingItem_movieId_fkey" FOREIGN KEY ("movieId") REFERENCES "Movie"("id") ON DELETE SET NULL ON UPDATE CASCADE;
