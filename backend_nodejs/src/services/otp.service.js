// ticket_booking_app\ticket_booking_backend\src\services\otp.service.js

const crypto = require('crypto');
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

function generateOtp() {
  return Math.floor(1000 + Math.random() * 9000).toString();
}

function hashOtp(otp) {
  return crypto.createHash('sha256').update(otp).digest('hex');
}

async function saveOtp(identifier, otp) {
  const hashed = hashOtp(otp);
  const expiry = new Date(Date.now() + 5 * 60 * 1000);

  await prisma.oTPRequest.create({
    data: { identifier, hashedOtp: hashed, expiresAt: expiry },
  });
}

async function verifyOtp(identifier, otp) {
  const hashed = hashOtp(otp);

  const record = await prisma.oTPRequest.findFirst({
    where: {
      identifier,
      hashedOtp: hashed,
      expiresAt: { gt: new Date() },
    },
    orderBy: { createdAt: 'desc' },
  });

  return Boolean(record);
  // if (!record) return false;

  // return record.hashedOtp === hashed;

}

module.exports = { generateOtp, hashOtp, saveOtp, verifyOtp };
