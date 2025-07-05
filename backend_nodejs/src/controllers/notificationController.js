// src/controllers/notificationController.js

const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

// GET /api/notifications/:userId
const getUserNotifications = async (req, res, next) => {
  try {
    const userId = req.user.id;
    const list = await prisma.notification.findMany({
      where: { userId },
      orderBy: { createdAt: 'desc' },
    });
    res.json(list);
  } catch (err) {
    // next(err);
    console.error(err);
    res.status(500).json({ error: 'Failed to fetch notifications' });
  }
};

// GET /api/notifications/unread-count/:userId
const getUnreadCount = async (req, res, next) => {
  try {
    const userId = req.user.id;

    const count = await prisma.notification.count({
      where: { userId, isRead: false },
    });
    res.json({ count });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to find unread count' });
  }
};

// PUT /api/notifications/mark-read/:id
const markNotificationRead = async (req, res) => {
  try {
    const notifId = parseInt(req.params.id, 10);

    if (isNaN(notifId)) {
      return res.status(400).json({ error: 'Invalid notification ID' });
    }

    const updatedNotification = await prisma.notification.update({
      where: { id: notifId },
      data: { isRead: true },
    });

    res.json({ success: true, notification: updatedNotification });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to mark-read the notification' });
  }
};

// POST /api/notifications/mark-all-read
const markAllNotificationsRead = async (req, res, next) => {
  try {
    const userId = req.user.id;
    await prisma.notification.updateMany({
      where: { userId, isRead: false },
      data: { isRead: true },
    });
    res.json({ success: true });
  } catch (err) {
    // next(err);
    console.error(err);
    res.status(500).json({ error: 'Failed to mark-read all notifications' });
  }
};

module.exports = {
  getUserNotifications,
  getUnreadCount,
  markNotificationRead,
  markAllNotificationsRead,
};
