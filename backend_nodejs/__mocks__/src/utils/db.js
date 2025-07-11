// ✅ __mocks__/src/utils/db.js
console.log("✅ __mocks__/src/utils/db.js loaded by Jest");

const mockUser = {
  id: "mock-user-id",
  name: "Mock User",
  email: "mock@example.com",
  mobile: "1234567890",
  verified: true,
  userType: "user",
};

const mockBooking = {
  id: "mock-booking-id",
  userId: mockUser.id,
  attractionId: "mock-attraction-id",
  ticketCount: 2,
  bookingDate: new Date(),
};

const mockOtpRequest = {
  id: "mock-otp-id",
  identifier: "mock@example.com",
  otp: "123456",
  expiresAt: new Date(Date.now() + 5 * 60 * 1000), // 5 minutes later
};

const mockPrisma = {
  user: {
    create: jest.fn().mockResolvedValue(mockUser),
    delete: jest.fn().mockResolvedValue({}),
    deleteMany: jest.fn().mockResolvedValue({}),
    findUnique: jest.fn().mockResolvedValue(mockUser),
    findFirst: jest.fn().mockResolvedValue(mockUser),
  },

  booking: {
    create: jest.fn().mockResolvedValue(mockBooking),
    findMany: jest.fn().mockResolvedValue([mockBooking]),
    deleteMany: jest.fn().mockResolvedValue({}),
  },

  oTPRequest: {
    create: jest.fn().mockResolvedValue(mockOtpRequest),
    findFirst: jest.fn(({ where }) => {
      if (
        where.identifier === mockOtpRequest.identifier &&
        where.otp === mockOtpRequest.otp &&
        mockOtpRequest.expiresAt > new Date()
      ) {
        return Promise.resolve(mockOtpRequest);
      }
      return Promise.resolve(null);
    }),
  },

  $disconnect: jest.fn().mockResolvedValue(undefined),
};

module.exports = mockPrisma;
