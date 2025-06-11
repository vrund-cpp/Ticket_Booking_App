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

const getAllMovies = async (req, res, next) => {
  try {
    const movies = await prisma.movie.findMany({ orderBy: { releaseDate: 'desc' } });
    res.json(movies);
  } catch (err) {
    next(err);
  }
};

module.exports={
  getLatestMovies,
  getAllMovies,
};
