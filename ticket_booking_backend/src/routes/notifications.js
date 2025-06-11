// src/routes/notifications.js

const express = require('express');
const router = express.Router();
const auth = require('../middleware/auth.middleware.js');

// Import exactly the functions exported from notificationController.js
const ctrl = require('../controllers/notificationController.js');


// All routes below require a valid token (authenticate)
// router.get('/:userId', ctrl.getUserNotifications);
// Example: GET /api/notifications/eeaac5d6-7cf3-4446-bb41-3cea762d7633

// GET all notifications (protected)
// router.get('/', auth, (req, res) => {
//   req.params.userId = req.userId;
//   ctrl.getUserNotifications(req, res);
// });


// router.get('/:userId/unread-count', ctrl.getUnreadCount);
// Example: GET /api/notifications/unread-count/eeaac5d6-7cf3-4446-bb41-3cea762d7633

// GET unread count (protected)
router.get('/count' , ctrl.getUnreadCount);
router.get('/', ctrl.getUserNotifications);
router.put('/mark-read/:id',ctrl.markNotificationRead);
router.post('/mark-all-read/:userId',ctrl.markAllNotificationsRead);

// Example: PATCH /api/notifications/mark-read/42

// router.patch('/:userId/mark-all-read', markAllNotificationsRead);
// Example: PATCH /api/notifications/mark-all-read/eeaac5d6-7cf3-4446-bb41-3cea762d7633

// POST mark all as read (protected)


module.exports = router;
