const prisma = require('../utils/db');

const getDashboardData = async (req, res, next) => {
  try {
    const [movies, outreachPrograms, attractions, news] = await Promise.all([
      prisma.movie.findMany({
        orderBy: { createdAt: 'desc' },
        take: 5,
      }),
      prisma.outreach.findMany({
        orderBy: { createdAt: 'desc' },
        take: 5,
      }),
      prisma.attraction.findMany({
        orderBy: { createdAt: 'desc' },
        take: 5,
      }),
      prisma.news.findMany({
        orderBy: { createdAt: 'desc' },
        take: 5,
      }),
    ]);

    res.json({
      movies,
      outreachPrograms,
      attractions,
      news,
    });
  } catch (error) {
    next(error); // passes to errorHandler middleware
  }
};

module.exports = {
  getDashboardData,
};
