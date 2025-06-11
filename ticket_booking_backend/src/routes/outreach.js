const express = require('express');
const prisma = require('../utils/db.js');
const router = express.Router();

const outreachController = require('../controllers/outreachController.js');

// GET /api/outreach/latest → top 5
router.get('/latest', outreachController.getLatestOutreachs);

// GET /api/outreach → all
router.get('/', outreachController.getAllOutreachs);

module.exports = router;
