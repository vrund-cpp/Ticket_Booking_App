const express = require('express');
const router = express.Router();
const getAllEntryTickets = require('../controllers/entryTicketsController');

// GET /api/entry-tickets
router.get('/', getAllEntryTickets);

module.exports = router;