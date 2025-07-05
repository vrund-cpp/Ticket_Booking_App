/*
  Warnings:

  - The values [two_d,three_d] on the enum `Format` will be removed. If these variants are still used in the database, this will fail.

*/
-- AlterEnum
BEGIN;
CREATE TYPE "Format_new" AS ENUM ('D2', 'D3');
ALTER TABLE "Movie" ALTER COLUMN "format" TYPE "Format_new" USING ("format"::text::"Format_new");
ALTER TYPE "Format" RENAME TO "Format_old";
ALTER TYPE "Format_new" RENAME TO "Format";
DROP TYPE "Format_old";
COMMIT;

-- AlterTable
ALTER TABLE "Attraction" ALTER COLUMN "updatedAt" DROP DEFAULT;

-- AlterTable
ALTER TABLE "Booking" ALTER COLUMN "updatedAt" DROP DEFAULT;

-- AlterTable
ALTER TABLE "EntryTicket" ALTER COLUMN "description" DROP DEFAULT,
ALTER COLUMN "updatedAt" DROP DEFAULT;

-- AlterTable
ALTER TABLE "Movie" ALTER COLUMN "updatedAt" DROP DEFAULT;

-- AlterTable
ALTER TABLE "Outreach" ALTER COLUMN "updatedAt" DROP DEFAULT;

-- AlterTable
ALTER TABLE "ParkingOption" ALTER COLUMN "updatedAt" DROP DEFAULT;

-- AlterTable
ALTER TABLE "User" ALTER COLUMN "updatedAt" DROP DEFAULT;
