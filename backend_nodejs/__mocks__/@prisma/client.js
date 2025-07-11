// ✅ __mocks__/@prisma/client.js

const crypto = require("crypto");

console.log("✅ __mocks__/@prisma/client.js loaded by Jest");

const hashedOtp = crypto.createHash('sha256').update("1234").digest('hex');

const mockOtpRequest = {
  id: "mock-otp-id",
  identifier: "user@example.com",
  otp: "1234",
  hashedOtp,
  expiresAt: new Date(Date.now() + 5 * 60 * 1000),
};

// ✅ Global Mock Database
const users = [
  {
    id: "user-1",
    email: "seed2@inboxkitten.com",
    password: "hashedpassword", // Simulated
    name: "Test User",
    role: "user",
  },
];

const prisma = {
  oTPRequest: {
    create: jest.fn().mockResolvedValue({}),
    findFirst: jest.fn(({ where }) => {
      if (
        where.identifier === mockOtpRequest.identifier &&
        where.hashedOtp === hashedOtp &&
        mockOtpRequest.expiresAt > new Date()
      ) {
        return Promise.resolve(mockOtpRequest);
      }
      return Promise.resolve(null);
    }),
  },

  user: {
    findFirst: jest.fn(({ where }) => {
      return Promise.resolve(users.find((u) => u.email === where.email) || null);
    }),
    findUnique: jest.fn(({ where }) => {
      return Promise.resolve(users.find((u) => u.id === where.id) || null);
    }),
    create: jest.fn(({ data }) => {
      const newUser = { ...data, id: `user-${users.length + 1}` };
      users.push(newUser);
      return Promise.resolve(newUser);
    }),
    update: jest.fn(({ where, data }) => {
      const index = users.findIndex((u) => u.id === where.id);
      if (index !== -1) {
        users[index] = { ...users[index], ...data };
        return Promise.resolve(users[index]);
      }
      return Promise.resolve(null);
    }),
  },

  booking: {
    create: jest.fn().mockResolvedValue({ id: "booking-1" }),
    findMany: jest.fn().mockResolvedValue([]),
  },

movie: {
  findMany: jest.fn().mockResolvedValue([
    {
      id: "mock-movie-id",
      title: "Mock Movie",
      language: "English",
      genre: "Action",
      description: "Mock description",
      imageUrl: "mock-thumbnail.png",
      releaseDate: new Date(),
    },
  ]),
},

  dashboard: {
    getStats: jest.fn().mockResolvedValue({ users: 10, bookings: 5 }),
  },
};

class PrismaClient {
  constructor() {
    return prisma;
  }
}

module.exports = { PrismaClient };
