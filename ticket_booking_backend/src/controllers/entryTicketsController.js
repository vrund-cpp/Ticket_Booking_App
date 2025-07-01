const prisma = require('../utils/db.js');

// GET /api/entry-tickets
const getAllEntryTickets = async (req, res) => {
  try {
    const tickets = await prisma.entryTicket.findMany();
    res.json(tickets);
  } catch (err) {
    res.status(500).json({ error: 'Failed to fetch entry tickets' })
  }
};

module.exports = getAllEntryTickets;


