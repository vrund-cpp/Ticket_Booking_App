-- AlterTable
ALTER TABLE "Attraction" ADD COLUMN     "tag" TEXT;

-- AlterTable
ALTER TABLE "Booking" ADD COLUMN     "tag" TEXT;

-- AlterTable
ALTER TABLE "BookingItem" ADD COLUMN     "tag" TEXT;

-- AlterTable
ALTER TABLE "EntryTicket" ADD COLUMN     "tag" TEXT;

-- AlterTable
ALTER TABLE "Movie" ADD COLUMN     "tag" TEXT;

-- AlterTable
ALTER TABLE "News" ADD COLUMN     "tag" TEXT;

-- AlterTable
ALTER TABLE "Notification" ADD COLUMN     "tag" TEXT;

-- AlterTable
ALTER TABLE "OTPRequest" ADD COLUMN     "tag" TEXT;

-- AlterTable
ALTER TABLE "Outreach" ADD COLUMN     "tag" TEXT;

-- AlterTable
ALTER TABLE "ParkingOption" ADD COLUMN     "tag" TEXT;

-- AlterTable
ALTER TABLE "Payment" ADD COLUMN     "tag" TEXT;

-- AlterTable
ALTER TABLE "User" ADD COLUMN     "tag" TEXT;
