const app = require('./app');
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

const PORT = process.env.PORT || 3000;
(async () => {
  try {
    await prisma.$connect();
    app.listen(PORT, () => console.log(`🚀 Server running on port ${PORT}`));
  } catch (e) {
    console.error('❌ Failed to connect to DB:', e);
    process.exit(1);
  }
})();
