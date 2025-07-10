module.exports = {
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
  // Add other models if needed
};
