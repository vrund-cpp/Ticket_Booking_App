const express = require('express');
const router = express.Router();
const { createBooking, getUserBookings } = require('../controllers/bookingController');

router.post('/', createBooking);

// ✅ Add this route for middleware + tests
router.get('/user', getUserBookings);

module.exports = router;
