// controllers/outreachController.js
const prisma = require('../utils/db');

const getLatestOutreachs = async (req, res, next) => {
  try {
    const list = await prisma.outreach.findMany({
      orderBy: { Startdate: 'desc' },
      take: 5,
    });
    if (list.length === 0) {
      return res.status(200).json({ message: 'No outreach found', data: [] });
    }
    res.json(list);
  } catch (err) {
    next(err);
  }
};

const getAllOutreachs = async (req, res, next) => {
  try {
    const events = await prisma.outreach.findMany({ orderBy: { Startdate: 'desc' } });
    if (events.length === 0) {
      return res.status(200).json({ message: 'No outreach found', data: [] });
    }
    res.json(events);
  } catch (err) {
    next(err);
  }
};

module.exports = {
  getLatestOutreachs,
  getAllOutreachs,
};
