// routes/attractions.js
const express = require('express');
const attractionsController = require('../controllers/attractionsController.js')
const router = express.Router();
const authMiddleware = require('../middleware/auth.middleware.js');

// GET /api/attractions/latest → top 5
router.get('/latest', authMiddleware ,attractionsController.getLatestAttractions);

// GET /api/attractions → all
router.get('/', authMiddleware ,attractionsController.getAllAttractions);

module.exports = router;
