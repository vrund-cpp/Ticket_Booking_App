// __mocks__/prismaClient.js

const user = {
  findUnique: jest.fn(),
};

const otpRequest = {
  create: jest.fn(),
  findFirst: jest.fn(),
};

const notification = {
  findMany: jest.fn(),
};

const booking = {
  findMany: jest.fn(),
};

const bookingItem = {
  createMany: jest.fn(),
};

const entryTicket = {
  findMany: jest.fn(),
};

const parkingOption = {
  findMany: jest.fn(),
};

const attraction = {
  findMany: jest.fn(),
};

const movie = {
  findMany: jest.fn(),
};

const outreach = {
  findMany: jest.fn(),
};

const news = {
  findMany: jest.fn(),
};

const payment = {
  create: jest.fn(),
};

const prisma = {
  user,
  otpRequest,
  notification,
  booking,
  bookingItem,
  entryTicket,
  parkingOption,
  attraction,
  movie,
  outreach,
  news,
  payment,
};

module.exports = { prisma };
