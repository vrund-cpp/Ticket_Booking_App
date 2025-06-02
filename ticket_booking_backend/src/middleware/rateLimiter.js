const express = require("express");
const app = express();
const rateLimit = require('express-rate-limit');

app.set("trust proxy", 1); // trust first proxy

const otpLimiter = rateLimit({
  windowMs: 5 * 60 * 1000,
  max: 3,
  message: 'Too many OTP requests. Please try again later.',
});

module.exports = { otpLimiter };
