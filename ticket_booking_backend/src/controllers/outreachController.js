// controllers/outreachController.js
const prisma = require('../utils/db');

const getLatestOutreachs = async (req, res, next) => {
  try {
    const list = await prisma.outreach.findMany({
      orderBy: { Startdate: 'desc' },
      take: 5,
    });
    res.json(list);
  } catch (err) {
    next(err);
  }
};

const getAllOutreachs = async (req, res, next) => {
  try {
    const events = await prisma.outreach.findMany({ orderBy: { Startdate: 'desc' } });
    res.json(events);
  } catch (err) {
    next(err);
  }
};

module.exports = {
  getLatestOutreachs,
  getAllOutreachs,  
};
