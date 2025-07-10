const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

if (process.env.NODE_ENV === 'test') {
  module.exports = require('../../__mocks__/prismaClient');
} else {
  const { PrismaClient } = require('@prisma/client');
  const prisma = new PrismaClient();
  module.exports =  prisma;
}

