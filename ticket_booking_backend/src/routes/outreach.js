const express = require('express');
const prisma = require('../utils/db.js');
const router = express.Router();
const authMiddleware = require('../middleware')

const outreachController = require('../controllers/outreachController.js');

// GET /api/outreach/latest → top 5
router.get('/latest', authMiddleware ,outreachController.getLatestOutreachs);

// GET /api/outreach → all
router.get('/', authMiddleware ,outreachController.getAllOutreachs);

module.exports = router;
