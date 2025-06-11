const express = require('express');
const prisma = require('../utils/db.js');

const router = express.Router();
const newsController = require('../controllers/newsController.js')
const authMiddleware = require('../middleware/auth.middleware.js');

// GET /api/news/latest → top 5
router.get('/latest', authMiddleware ,newsController.getNews);

// GET /api/news → all
router.get('/', authMiddleware ,newsController.getAllNews);

module.exports = router;
