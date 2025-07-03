const express = require('express');
const router = express.Router();
const getAllParkingOptions = require('../controllers/parkingOptionsController');

router.get('/', getAllParkingOptions);

module.exports = router;
