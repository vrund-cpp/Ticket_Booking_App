const prisma = require('../utils/db.js');

const getAllParkingOptions = async (req, res) => {
  try {
    const options = await prisma.parkingOption.findMany();
    res.json(options);
  } catch (err) {
    res.status(500).json({ error: 'Failed to fetch parking options' });
  }
};

module.exports = getAllParkingOptions;
