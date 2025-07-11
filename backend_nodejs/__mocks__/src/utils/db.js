// __mocks__/src/utils/db.js

console.log("✅ __mocks__/src/utils/db.js loaded by Jest");

const mockPrisma = {
  oTPRequest: {
    create: jest.fn(),
    findFirst: jest.fn(),
    deleteMany: jest.fn(),
  },
  attraction: {
    findMany: jest.fn(),
  },
  movie: {
    findMany: jest.fn(),
  },
  user: {
    findUnique: jest.fn(),
    update: jest.fn(),
  },
};

module.exports = mockPrisma;
