const express = require('express');
const router = express.Router();
const authController = require('../controllers/auth.controller');
const { otpLimiter } = require('../middleware/rateLimiter');

router.post('/signup', authController.signup);
router.post("/login", authController.login);
router.post('/request-otp', otpLimiter, authController.requestOtp);
router.post('/verify-otp', authController.verifyOtp);

module.exports = router;
