/*
  Warnings:

  - Made the column `description` on table `Attraction` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE "Attraction" ALTER COLUMN "description" SET NOT NULL,
ALTER COLUMN "description" SET DEFAULT 'No description available.';
