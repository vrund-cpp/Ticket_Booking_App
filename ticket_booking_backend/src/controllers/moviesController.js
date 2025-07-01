// controllers/moviesController.js
const prisma = require('../utils/db');

const getLatestMovies = async (req, res, next) => {
  try {
    const movies = await prisma.movie.findMany({
      orderBy: { releaseDate: 'desc' },
      take: 5,
    });
    res.json(movies);
  } catch (err) {
    next(err);
  }
}

const getAllMovies = async (req, res) => {
  try {
    const movies = await prisma.movie.findMany();
    res.json(movies);
  } catch (err) {
    res.status(500).json({ error: 'Failed to fetch movies' });
  }
};

module.exports={
  getLatestMovies,
  getAllMovies,
};
