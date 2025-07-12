// __mocks__/src/utils/db.js
console.log("✅ __mocks__/src/utils/db.js loaded by Jest");

const mockFindMany = jest.fn();

const prisma = {
  user: {
    findFirst: jest.fn(),
    findUnique: jest.fn(),
    create: jest.fn(),
    updateMany: jest.fn(),
    update: jest.fn(),
  },
  movie: {
    findMany: mockFindMany,
  },
  notification: {
    findMany: jest.fn(),
    count: jest.fn(),
    update: jest.fn(),
    updateMany: jest.fn(),
  }
};

module.exports = prisma;
