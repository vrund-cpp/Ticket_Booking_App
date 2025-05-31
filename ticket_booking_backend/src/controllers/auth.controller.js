const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();
const { isValidEmail, isValidMobile } = require('../utils/validators');
const { sendEmail } = require('../services/email.service');
const { generateOtp, saveOtp, verifyOtp } = require('../services/otp.service');

exports.signup = async (req, res) => {
  const { name, email, mobile } = req.body;

  if (!isValidEmail(email) || !isValidMobile(mobile)) {
    return res.status(400).json({ message: 'Invalid email or mobile' });
  }

  try {
    const existing = await prisma.user.findFirst({
      where: {
        OR: [{ email }, { mobile }]
      }
    });

    if (existing) {
      return res.status(409).json({
        message: 'User already exists with this email or mobile'
      });
    }

    const otp = generateOtp();
    await saveOtp(email, otp);
    await sendEmail(email, otp);

    await prisma.user.create({
      data: { name, email, mobile }
    });

    return res.status(200).json({ message: 'OTP sent' });
  } catch (err) {
    console.error('❌ Signup error:', err);
    return res.status(500).json({ message: 'Server error' });
  }
};

exports.requestOtp = async (req, res) => {
  const { identifier } = req.body || {};
  if (!identifier) return res.status(400).json({ message: 'Identifier is required' });

  const isEmail = isValidEmail(identifier);
  const isMobile = isValidMobile(identifier);

  if (!isEmail && !isMobile) return res.status(400).json({ message: 'Invalid identifier' });

  const otp = generateOtp();
  await saveOtp(identifier, otp);

  if (isEmail) await sendEmail(identifier, otp);
  // For mobile, integrate SMS API here

  return res.status(200).json({ message: 'OTP sent' });
};

exports.login = async (req, res) => {
  const { email } = req.body;

  try {
    const user = await prisma.user.findUnique({ where: { email } });

    if (!user) return res.status(404).json({ message: "User not found" });

    const otp = generateOtp();
    await saveOtp(email, otp);
    await sendEmail(email, otp);

    res.status(200).json({ message: "OTP sent" });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.verifyOtp = async (req, res) => {
  const { identifier, otp } = req.body || {};
  if (!identifier || !otp) {
    return res.status(400).json({ message: 'Identifier and OTP are required' });
  }

  try {
    const isValid = await verifyOtp(identifier, otp);
    if (!isValid) {
      return res.status(400).json({ message: "Invalid or expired OTP" });
    }

    await prisma.user.updateMany({
      where: {
        OR: [{ email: identifier }, { mobile: identifier }]
      },
      data: { verified: true }
    });

    res.status(200).json({ message: "Verified successfully" });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};
