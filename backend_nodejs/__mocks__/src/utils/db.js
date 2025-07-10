const mockPrisma = {
  oTPRequest: {
    create: jest.fn(),
    findFirst: jest.fn(),
  },
  attraction: {
    findMany: jest.fn(),
  },
  movie: {
    findMany: jest.fn(),
  },
  user: {
    findUnique: jest.fn(),
  },
  // Add more model mocks as needed
};

module.exports = mockPrisma;
