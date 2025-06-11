const express = require('express');
const prisma = require('../utils/db.js');
const moviesController = require('../controllers/moviesController.js');
const authMiddleware = require('../middleware/auth.middleware.js');


const router = express.Router();

// GET /api/movies/latest → top 5
router.get('/latest', authMiddleware ,moviesController.getLatestMovies);

// GET /api/movies → all
router.get('/', authMiddleware ,moviesController.getAllMovies);

module.exports = router;
