const express = require('express');
const app = reqire('app');
const router = express.Router();
const authController = require('../controllers/auth.controller');
const { otpLimiter } = require('../middleware/rateLimiter');

router.post('/signup', authController.signup);
router.post("/login", authController.login);
router.post('/request-otp', otpLimiter, authController.requestOtp);
router.post('/verify-otp', authController.verifyOtp);

app.get('/push-schema', async (req, res) => {
  const { exec } = require('child_process');
  exec('npx prisma db push', (err, stdout, stderr) => {
    if (err) {
      console.error(stderr);
      return res.status(500).send('Error pushing schema');
    }
    res.send('Schema pushed successfully:\n' + stdout);
  });
});

module.exports = router;
