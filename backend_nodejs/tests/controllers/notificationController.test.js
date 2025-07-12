// tests/controllers/notificationController.test.js
jest.mock('../../src/utils/db'); // ✅ adjust if your test is deep inside /tests

const httpMocks = require('node-mocks-http');
const prisma = require('../../src/utils/db');
const notificationController = require('../../src/controllers/notificationController');

describe('🔔 Notification Controller', () => {
  const mockUser = { id: 1 };

  beforeEach(() => {
    jest.clearAllMocks();
  });

  test('📩 getUserNotifications returns list', async () => {
    const req = httpMocks.createRequest({
      method: 'GET',
      user: mockUser,
    });
    const res = httpMocks.createResponse();

    const fakeData = [
      { id: 1, title: 'Test 1' },
      { id: 2, title: 'Test 2' },
    ];

    prisma.notification.findMany.mockResolvedValue(fakeData);

    await notificationController.getUserNotifications(req, res);

    expect(prisma.notification.findMany).toHaveBeenCalledWith({
      where: { userId: mockUser.id },
      orderBy: { createdAt: 'desc' },
    });

    const data = res._getJSONData();
    expect(res.statusCode).toBe(200);
    expect(data).toEqual(fakeData);
  });

  test('🔢 getUnreadCount returns count', async () => {
    const req = httpMocks.createRequest({
      method: 'GET',
      user: mockUser,
    });
    const res = httpMocks.createResponse();

    prisma.notification.count.mockResolvedValue(3);

    await notificationController.getUnreadCount(req, res);

    expect(prisma.notification.count).toHaveBeenCalledWith({
      where: { userId: mockUser.id, isRead: false },
    });

    expect(res._getJSONData()).toEqual({ count: 3 });
    expect(res.statusCode).toBe(200);
  });

  test('✅ markNotificationRead updates a single notification', async () => {
    const req = httpMocks.createRequest({
      method: 'PUT',
      params: { id: '5' },
    });
    const res = httpMocks.createResponse();

    const fakeNotif = { id: 5, isRead: true };

    prisma.notification.update.mockResolvedValue(fakeNotif);

    await notificationController.markNotificationRead(req, res);

    expect(prisma.notification.update).toHaveBeenCalledWith({
      where: { id: 5 },
      data: { isRead: true },
    });

    expect(res._getJSONData()).toEqual({ success: true, notification: fakeNotif });
    expect(res.statusCode).toBe(200);
  });

  test('✅ markAllNotificationsRead updates many notifications', async () => {
    const req = httpMocks.createRequest({
      method: 'POST',
      user: mockUser,
    });
    const res = httpMocks.createResponse();

    prisma.notification.updateMany.mockResolvedValue({ count: 5 });

    await notificationController.markAllNotificationsRead(req, res);

    expect(prisma.notification.updateMany).toHaveBeenCalledWith({
      where: { userId: mockUser.id, isRead: false },
      data: { isRead: true },
    });

    expect(res._getJSONData()).toEqual({ success: true });
    expect(res.statusCode).toBe(200);
  });
});
