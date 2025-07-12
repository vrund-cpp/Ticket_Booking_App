// ticket_booking_backend\src\services\email.service.js

if (process.env.NODE_ENV === 'test') {
  module.exports = {
    // still export sendEmail (not sendMail) so authController.import works
    sendEmail: async (...args) => {
      console.log("📨 Mock email sent");
      return { messageId: 'mocked-id' };
    }
  };
} else {
const nodemailer = require('nodemailer');

function getTransporter() {
return nodemailer.createTransport({
  host: 'smtp.gmail.com',
  port: 587, // ✅ Not 465
  secure: false, // ⚠️ Must be false for port 587
  auth: {
    user: process.env.EMAIL_USER,
    pass: process.env.EMAIL_PASS,
  },
});
}

async function sendEmail(email, otp) {
   const transporter = getTransporter(); // ✅ Call after mock applied
  await transporter.sendMail({
    from: `"My App" <${process.env.EMAIL_USER}>`,
    to: email,
    subject: 'Your OTP Code For Ticket Booking App',
    text: `Your OTP is: ${otp}. It will expire in 1 minute.`,
  });
}

module.exports = { sendEmail };

}

