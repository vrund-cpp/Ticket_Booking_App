// src/routes/notifications.js

const express = require('express');
const router = express.Router();

// Import exactly the functions exported from notificationController.js
const ctrl = require('../controllers/notificationController.js');

router.get('/count', ctrl.getUnreadCount);
router.get('/', ctrl.getUserNotifications);
router.put('/mark-read/:id', ctrl.markNotificationRead);
router.post('/mark-all-read', ctrl.markAllNotificationsRead);

module.exports = router;
