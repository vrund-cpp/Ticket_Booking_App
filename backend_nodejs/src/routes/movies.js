const express = require('express');
const moviesController = require('../controllers/moviesController.js');

const router = express.Router();

// GET /api/movies/latest → top 5
router.get('/latest', moviesController.getLatestMovies);

// GET /api/movies → all
router.get('/', moviesController.getAllMovies);

module.exports = router;
