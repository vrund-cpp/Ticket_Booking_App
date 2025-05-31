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
  });

  return Boolean(record);
}

module.exports = { generateOtp, hashOtp, saveOtp, verifyOtp };
