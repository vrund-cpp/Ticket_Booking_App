const express = require('express');
const router = express.Router();
const {createBooking} = require('../controllers/bookingController');

router.post('/', createBooking);

// PATCH /api/bookings/:bookingId/confirm
// router.patch('/:bookingId/confirm', confirmBooking);

module.exports = router;
