const prisma = require('../utils/db.js');

const getAllParkingOptions = async (req, res) => {
  try {
    const options = await prisma.parkingOption.findMany();
    if (options.length === 0) {
      return res.status(200).json({ message: 'No parking options found', data: [] });
    }
    res.json(options);
  } catch (err) {
    res.status(500).json({ error: 'Failed to fetch parking options' });
  }
};

module.exports = getAllParkingOptions;
