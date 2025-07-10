let prisma;

if (process.env.NODE_ENV === 'test') {
  prisma = require('../../__mocks__/prismaClient'); // use mock client in tests
} else {
  const { PrismaClient } = require('@prisma/client');
  prisma = new PrismaClient();
}

module.exports = prisma;
