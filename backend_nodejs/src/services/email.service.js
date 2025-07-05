// ticket_booking_backend\src\services\email.service.js

const nodemailer = require('nodemailer');

const transporter = nodemailer.createTransport({
  host: 'smtp.gmail.com',
  port: 587, // ✅ Not 465
  secure: false, // ⚠️ Must be false for port 587
  auth: {
    user: process.env.EMAIL_USER,
    pass: process.env.EMAIL_PASS,
  },
});

async function sendEmail(email, otp) {
  await transporter.sendMail({
    from: `"My App" <${process.env.EMAIL_USER}>`,
    to: email,
    subject: 'Your OTP Code For Ticket Booking App',
    text: `Your OTP is: ${otp}. It will expire in 1 minute.`,
  });
}

module.exports = { sendEmail };
