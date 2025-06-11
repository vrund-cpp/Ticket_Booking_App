// controllers/attractionsController.js
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

const getLatestAttractions = async (req,res) => {
  const attractions = await prisma.attraction.findMany({
    orderBy: { createdAt: 'desc' },
    take: 5,
  });
  res.json(attractions);
};

const getAllAttractions = async (req, res) => {
  const attractions = await prisma.attraction.findMany({
    orderBy: { createdAt: 'desc' },
  });
  res.json(attractions);
};

module.exports = {
  getLatestAttractions,
  getAllAttractions,
};
