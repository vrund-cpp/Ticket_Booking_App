-- AlterTable
ALTER TABLE "User" ADD COLUMN     "otp" TEXT,
ADD COLUMN     "verified" BOOLEAN NOT NULL DEFAULT false;
