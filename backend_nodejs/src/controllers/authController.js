// ticket_booking_app\ticket_booking_backend\src\controllers\authController.js

const prisma = require('../utils/db');
const { isValidEmail, isValidMobile } = require('../utils/validators');
const { sendEmail } = require('../services/email.service');
const { generateOtp, saveOtp, verifyOtp } = require('../services/otp.service');
const jwt = require('jsonwebtoken');
const JWT_SECRET = process.env.JWT_SECRET;

const signup = async (req, res) => {
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

const requestOtp = async (req, res) => {

  const { identifier } = req.body || {};
  if (!identifier) return res.status(400).json({ message: 'Identifier is required' });

  try {
    const isEmail = isValidEmail(identifier);
    const isMobile = isValidMobile(identifier);

    if (!isEmail) return res.status(400).json({ message: 'Invalid identifier' });

    const otp = generateOtp();
    await saveOtp(identifier, otp);

    if (isEmail) await sendEmail(identifier, otp);
    // For mobile, integrate SMS API here

    return res.status(200).json({ message: 'OTP sent' });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Internal server error' });
  }

};

const login = async (req, res) => {
  const { email } = req.body;
  console.log('📩 Received email:', email);  // 👈 Log incoming email

  try {
    const user = await prisma.user.findUnique({ where: { email } });
    console.log('👤 Fetched user:', user);  // 👈 Log result of Prisma query

    if (!user) return res.status(404).json({ message: "User not found" });

    const otp = generateOtp();
    await saveOtp(email, otp);
    await sendEmail(email, otp);

    res.status(200).json({ message: "OTP sent" });
  } catch (error) {
    console.error('💥 Login error:', error);
    res.status(500).json({ error: error.message });
  }
};

const verifyOtpctrl = async (req, res) => {
  const { identifier, otp } = req.body || {};
  if (!identifier || !otp) {
    return res.status(400).json({ message: 'Identifier and OTP are required' });
  }


  try {
    const isValid = await verifyOtp(identifier.trim(), otp.trim());
    if (!isValid) {
      return res.status(401).json({ message: "Invalid or expired OTP" });
    }
    await prisma.user.updateMany({
      where: { OR: [{ email: identifier }, { mobile: identifier }] },
      data: { verified: true }
    });

    // fetch the user so we can sign their id
    const user = await prisma.user.findFirst({
      where: { OR: [{ email: identifier }, { mobile: identifier }] }
    });

    if (!user) {
      return res.status(404).json({ message: 'User not found after verification' });
    }

    await prisma.user.update({
      where: { id: user.id },
      data: { verified: true },
    });

    const payload = { userId: user.id };
    const token = jwt.sign(
      payload,
      JWT_SECRET,
      { expiresIn: '7d' }
    );

    // Optional: delete OTPs for security
    // await prisma.oTPRequest.deleteMany({ where: { identifier } });

    res.status(200).json({ message: "Verified successfully", token });
    // res.status(200).json({ message: "Verified successfully" });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

module.exports = {
  signup,
  login,
  verifyOtpctrl,
  requestOtp,
};
