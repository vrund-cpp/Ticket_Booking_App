// routes/attractions.js
const express = require('express');
const attractionsController = require('../controllers/attractionsController.js')
const router = express.Router();

// GET /api/attractions/latest → top 5
router.get('/latest', attractionsController.getLatestAttractions);

// GET /api/attractions → all
router.get('/', attractionsController.getAllAttractions);

module.exports = router;
