// File: backend/index.js

const express = require('express');
const cors =  require('cors');
const dotenv =  require('dotenv');
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

const authRoutes = require('./routes/auth.js');
const moviesRoutes = require('./routes/movies.js');
const outreachRoutes = require('./routes/outreach.js');
const attractionsRoutes = require('./routes/attractions.js');
const newsRoutes = require('./routes/news.js');
const notificationsRoutes = require('./routes/notifications.js');
const authMiddleware = require('./middleware/auth.middleware.js');

require('dotenv').config();
const app = express();

app.use(express.json());

// Public Routes
app.use('/api/auth', authRoutes);
// app.use('/api/quick-booking', quickBookingRoutes);
app.use('/api/movies/latest', moviesRoutes);
app.use('/api/movies', moviesRoutes);
app.use('/api/outreach', outreachRoutes);
app.use('/api/outreach/latest', outreachRoutes);
app.use('/api/attractions', attractionsRoutes);
app.use('/api/attractions/latest', attractionsRoutes);
app.use('/api/news/latest', newsRoutes);
app.use('/api/news', newsRoutes);

// Protected Routes (JWT)
app.use('/api/notifications', authMiddleware ,notificationsRoutes);


// --- HEALTHCHECK ---
app.get('/api/health', (req, res) => res.json({ status: 'OK' }));

// Global Error Handler
// app.use(errorHandler);
app.use((err, req, res, next) => {
  console.error(err);
  res.status(err.status || 500).json({ message: err.message || 'Server error' });
});

const PORT = process.env.PORT || 3000;

app.get('/', (req, res) => res.send('🟢 Backend running'));
// app.use((req, res) => res.status(404).json({ error: 'Not found' }));

app.listen(PORT, '0.0.0.0', () => {
  console.log(`Server running on http://0.0.0.0:${PORT}`);
});
// app.listen(PORT, () => console.log(`🟢 Server running on port ${PORT}`));


  // "scripts": {
  //   "start": "node server.js",
  //   "postinstall": "npx prisma generate && npx prisma db push"
  // },