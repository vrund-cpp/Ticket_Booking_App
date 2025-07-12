const express = require('express');
const cors = require('cors');
require('dotenv').config({
  path: process.env.NODE_ENV === 'test' ? '.env.test' : '.env'
});

const app = express();
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

app.set("trust proxy", 1); // trust first proxy

// app.get('/push-schema', async (req, res) => {
//   const { exec } = require('child_process');
//   exec('npx prisma db push', (err, stdout, stderr) => {
//     if (err) {
//       console.error(stderr);
//       return res.status(500).send('Error pushing schema');
//     }
//     res.send('Schema pushed successfully:\n' + stdout);
//   });
// });
app.use(cors({ origin: true, credentials: true }));
app.use(express.json());

const authRoutes = require('./src/routes/auth');
const moviesRoutes = require('./src/routes/movies');
const outreachRoutes = require('./src/routes/outreach');
const attractionsRoutes = require('./src/routes/attractions');
const newsRoutes = require('./src/routes/news');
const notificationsRoutes = require('./src/routes/notifications');
const entryRoutes = require('./src/routes/entryTickets');
const parkingRoutes = require('./src/routes/parkingOptions');
const bookingRoutes = require('./src/routes/bookings');
const paymentRoutes = require('./src/routes/payments');
const userProfileRoutes = require('./src/routes/userProfile');
const authMiddleware = require('./src/middleware/auth.middleware');

app.use('/api/auth', authRoutes);
app.use('/api/movies', authMiddleware, moviesRoutes);
app.use('/api/outreach', authMiddleware, outreachRoutes);
app.use('/api/attractions', authMiddleware, attractionsRoutes);
app.use('/api/news', authMiddleware, newsRoutes);
app.use('/api/notifications', authMiddleware, notificationsRoutes);
app.use('/api/entry-tickets', authMiddleware, entryRoutes);
app.use('/api/parking-options', authMiddleware, parkingRoutes);
app.use('/api/bookings', authMiddleware, bookingRoutes);
app.use('/api/payments', authMiddleware, paymentRoutes);
app.use('/api/profile', authMiddleware, userProfileRoutes);

app.use((req, res, next) => {
  console.log("404 fallback hit for:", req.path);
  res.status(404).send({ message: "Route not found" });
});

// ✅ Add this test route to check DB connection
app.get('/push-schema', async (req, res) => {
  try {
    await prisma.$connect();
    res.send('✅ Connected to DB and Prisma is working');
  } catch (err) {
    console.error(err);
    res.status(500).send('❌ Error connecting to DB');
  }
});

module.exports = app;
