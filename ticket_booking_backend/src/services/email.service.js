// ticket_booking_backend\src\services\email.service.js

const nodemailer = require('nodemailer');

const transporter = nodemailer.createTransport({
  service: 'gmail',
  auth: {
    user: process.env.EMAIL_USER,
    pass: process.env.EMAIL_PASS,
  },
});

async function sendEmail(to, otp) {
  await transporter.sendMail({
    from: process.env.EMAIL_USER,
    to,
    subject: 'Your OTP Code For Ticket Booking App',
    text: `Your OTP is: ${otp}. It will expire in 1 minute.`,
  });
}

module.exports = { sendEmail };
