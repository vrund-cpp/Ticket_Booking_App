/*
  Warnings:

  - The primary key for the `Outreach` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The `id` column on the `Outreach` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - Made the column `description` on table `Attraction` required. This step will fail if there are existing NULL values in that column.
  - Made the column `description` on table `Movie` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE "Attraction" ALTER COLUMN "description" SET NOT NULL,
ALTER COLUMN "title" DROP NOT NULL,
ALTER COLUMN "updatedAt" SET DEFAULT CURRENT_TIMESTAMP;

-- AlterTable
ALTER TABLE "Movie" ALTER COLUMN "description" SET NOT NULL,
ALTER COLUMN "updatedAt" SET DEFAULT CURRENT_TIMESTAMP;

-- AlterTable
ALTER TABLE "Outreach" DROP CONSTRAINT "Outreach_pkey",
DROP COLUMN "id",
ADD COLUMN     "id" SERIAL NOT NULL,
ALTER COLUMN "updatedAt" SET DEFAULT CURRENT_TIMESTAMP,
ADD CONSTRAINT "Outreach_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "User" ALTER COLUMN "updatedAt" SET DEFAULT CURRENT_TIMESTAMP;
