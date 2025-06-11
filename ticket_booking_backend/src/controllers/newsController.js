// controllers/newsController.js
const prisma = require('../utils/db');

const getNews = async (req, res, next) => {
  try {
    const list = await prisma.news.findMany({
      orderBy: { date: 'desc' },
      take: 5,
    });
    res.json(list);
  } catch (err) {
    next(err);
  }
};

const getAllNews = async (req, res, next) => {
  try {
    const items = await prisma.news.findMany({ orderBy: { date: 'desc' } });
    res.json(items);
  } catch (err) {
    next(err);
  }
};

module.exports = {
  getNews,
  getAllNews,
};