// controllers/attractionsController.js
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

const getLatestAttractions = async (req,res) => {
  try{const attractions = await prisma.attraction.findMany({
    orderBy: { createdAt: 'desc' },
    take: 5,
  });
  res.json(attractions);}
  catch (err) {
    res.status(500).json({ error: 'Failed to fetch attractions' });
  }
};

const getAllAttractions = async (req, res) => {
  try{const attractions = await prisma.attraction.findMany({
  });
  res.json(attractions);}
  catch (err) {
    res.status(500).json({ error: 'Failed to fetch attractions' });
  }
};

module.exports = {
  getLatestAttractions,
  getAllAttractions,
};
