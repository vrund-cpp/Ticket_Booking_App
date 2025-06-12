const express = require('express');
const router = express.Router();
const  dashboardController  = require('../controllers/dashboardController');
const authMiddleware = require('../middleware/auth.middleware.js');

router.get('/dashboard', authMiddleware  ,dashboardController.getDashboardData);

module.exports = router;