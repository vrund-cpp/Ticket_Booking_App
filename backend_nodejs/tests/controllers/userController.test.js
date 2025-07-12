// tests/controllers/userController.test.js
jest.mock('../../src/utils/db'); // use the mocked prisma client
const prisma = require('../../src/utils/db');
const httpMocks = require('node-mocks-http');
const { getProfile, updateProfile } = require('../../src/controllers/userController');

describe('👤 User Controller', () => {
  const mockUser = {
    id: 1,
    name: 'Vrund',
    email: 'vrund@example.com',
    mobile: '1234567890'
  };

  beforeEach(() => {
    jest.clearAllMocks();
  });

  describe('GET /api/profile', () => {
    it('should return profile and formatted bookings', async () => {
      const req = httpMocks.createRequest({
        method: 'GET',
        user: { id: 1 }
      });
      const res = httpMocks.createResponse();

      prisma.user.findUnique.mockResolvedValue(mockUser);

      prisma.booking = {
        findMany: jest.fn().mockResolvedValue([
          {
            id: 101,
            totalPrice: 500,
            createdAt: new Date(),
            status: 'Confirmed',
            items: [
              { type: 'entry_ticket', pricePerUnit: 100, quantity: 2 },
              { type: 'parking', pricePerUnit: 50, quantity: 2 },
              { type: 'movie', pricePerUnit: 100, quantity: 1 }
            ]
          }
        ])
      };

      await getProfile(req, res);

      const json = res._getJSONData();

      expect(res.statusCode).toBe(200);
      expect(json.user).toEqual(mockUser);
      expect(json.bookings).toHaveLength(1);
      expect(json.bookings[0]).toHaveProperty('entryAmount');
      expect(json.bookings[0]).toHaveProperty('parkingAmount');
      expect(json.bookings[0]).toHaveProperty('movieAmount');
    });

    it('should return 401 if user not found on req', async () => {
      const req = httpMocks.createRequest({ method: 'GET' });
      const res = httpMocks.createResponse();

      await getProfile(req, res);

      expect(res.statusCode).toBe(401);
      expect(res._getJSONData()).toEqual({
        message: 'Unauthorized – user not found'
      });
    });

    it('should handle server error', async () => {
      const req = httpMocks.createRequest({ user: { id: 1 } });
      const res = httpMocks.createResponse();

      prisma.user.findUnique.mockRejectedValue(new Error('DB Error'));

      await getProfile(req, res);

      expect(res.statusCode).toBe(500);
      expect(res._getJSONData()).toEqual({
        message: 'Internal server Error'
      });
    });
  });

  describe('PUT /api/profile', () => {
    it('should update user profile', async () => {
      const req = httpMocks.createRequest({
        method: 'PUT',
        user: { id: 1 },
        body: {
          name: 'Updated',
          email: 'updated@example.com',
          mobile: '9999999999'
        }
      });
      const res = httpMocks.createResponse();

      prisma.user.update.mockResolvedValue({
        id: 1,
        name: 'Updated',
        email: 'updated@example.com',
        mobile: '9999999999'
      });

      await updateProfile(req, res);

      expect(res.statusCode).toBe(200);
      expect(res._getJSONData()).toEqual({
        success: true,
        user: {
          id: 1,
          name: 'Updated',
          email: 'updated@example.com',
          mobile: '9999999999'
        }
      });
    });

    it('should return 400 if any field is missing', async () => {
      const req = httpMocks.createRequest({
        method: 'PUT',
        user: { id: 1 },
        body: { name: '', email: '', mobile: '' }
      });
      const res = httpMocks.createResponse();

      await updateProfile(req, res);

      expect(res.statusCode).toBe(400);
      expect(res._getJSONData()).toEqual({
        success: false,
        message: 'All fields (name, email, mobile) are required.'
      });
    });

    it('should handle update error', async () => {
      const req = httpMocks.createRequest({
        method: 'PUT',
        user: { id: 1 },
        body: {
          name: 'X',
          email: 'x@example.com',
          mobile: '999'
        }
      });
      const res = httpMocks.createResponse();

      prisma.user.update.mockRejectedValue(new Error('DB Error'));

      await updateProfile(req, res);

      expect(res.statusCode).toBe(500);
      expect(res._getJSONData()).toEqual({
        success: false,
        message: 'Internal server Error'
      });
    });
  });
});
