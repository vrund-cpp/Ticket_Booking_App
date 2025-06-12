const express = require('express');
const router = express.Router();
const newsController = require('../controllers/newsController.js');

// GET /api/news/latest → top 5
router.get('/latest' ,newsController.getNews);

// GET /api/news → all
router.get('/' ,newsController.getAllNews);

module.exports = router;
