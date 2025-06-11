/*
  Warnings:

  - You are about to drop the column `subtitle` on the `Movie` table. All the data in the column will be lost.
  - You are about to drop the column `imageUrl` on the `News` table. All the data in the column will be lost.
  - You are about to drop the column `title` on the `News` table. All the data in the column will be lost.
  - You are about to drop the column `dateEnd` on the `Outreach` table. All the data in the column will be lost.
  - You are about to drop the column `dateStart` on the `Outreach` table. All the data in the column will be lost.
  - You are about to drop the `BookingOption` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Entry` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `QuickBookingItem` table. If the table is not empty, all the data it contains will be lost.

*/
-- AlterTable
ALTER TABLE "Movie" DROP COLUMN "subtitle",
ADD COLUMN     "description" TEXT NOT NULL DEFAULT 'No description available.';

-- AlterTable
ALTER TABLE "News" DROP COLUMN "imageUrl",
DROP COLUMN "title";

-- AlterTable
ALTER TABLE "Outreach" DROP COLUMN "dateEnd",
DROP COLUMN "dateStart",
ADD COLUMN     "Enddate" TIMESTAMP(3),
ADD COLUMN     "Startdate" TIMESTAMP(3);

-- DropTable
DROP TABLE "BookingOption";

-- DropTable
DROP TABLE "Entry";

-- DropTable
DROP TABLE "QuickBookingItem";
