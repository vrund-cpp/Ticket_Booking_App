// controllers/newsController.js
const prisma = require('../utils/db');

const getNews = async (req, res, next) => {
  try {
    const list = await prisma.news.findMany({
      orderBy: { date: 'desc' },
      take: 5,
    });
    if (list.length === 0) {
      return res.status(200).json({ message: 'No news found', data: [] });
    }
    res.json(list);
  } catch (err) {
    next(err);
  }
};

const getAllNews = async (req, res, next) => {
  try {
    const items = await prisma.news.findMany({ orderBy: { date: 'desc' } });
    if (items.length === 0) {
      return res.status(200).json({ message: 'No news found', data: [] });
    }
    res.json(items);
  } catch (err) {
    next(err);
  }
};

module.exports = {
  getNews,
  getAllNews,
};