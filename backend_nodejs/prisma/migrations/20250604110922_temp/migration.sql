/*
  Warnings:

  - You are about to drop the column `description` on the `Attraction` table. All the data in the column will be lost.
  - You are about to drop the column `icon` on the `Entry` table. All the data in the column will be lost.
  - You are about to drop the column `date` on the `News` table. All the data in the column will be lost.
  - You are about to drop the column `description` on the `News` table. All the data in the column will be lost.
  - You are about to drop the column `title` on the `News` table. All the data in the column will be lost.
  - You are about to drop the `Parking` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `type` to the `Entry` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Attraction" DROP COLUMN "description",
ADD COLUMN     "details" TEXT,
ADD COLUMN     "price" DOUBLE PRECISION;

-- AlterTable
ALTER TABLE "Entry" DROP COLUMN "icon",
ADD COLUMN     "description" TEXT,
ADD COLUMN     "iconUrl" TEXT,
ADD COLUMN     "price" DOUBLE PRECISION,
ADD COLUMN     "type" TEXT NOT NULL,
ALTER COLUMN "title" DROP NOT NULL;

-- AlterTable
ALTER TABLE "Movie" ADD COLUMN     "description" TEXT NOT NULL DEFAULT 'No description available.';

-- AlterTable
ALTER TABLE "News" DROP COLUMN "date",
DROP COLUMN "description",
DROP COLUMN "title",
ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "headline" TEXT,
ADD COLUMN     "imageUrl" TEXT,
ADD COLUMN     "published" TIMESTAMP(3),
ADD COLUMN     "summary" TEXT;

-- AlterTable
ALTER TABLE "OutreachProgram" ADD COLUMN     "location" TEXT;

-- DropTable
DROP TABLE "Parking";
