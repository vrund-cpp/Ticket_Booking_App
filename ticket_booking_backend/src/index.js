// File: backend/index.js

const express = require('express');
const app = require('../app');
// const cors =  require('cors');
// const dotenv =  require('dotenv');
// const { PrismaClient } = require('@prisma/client');
// const prisma = new PrismaClient();

// const authRoutes = require('./routes/auth.js');
// const entryTicketsRoutes = require('./routes/entryTickets.js');
// const parkingOptionsRoutes = require('./routes/parkingOptions.js');
// const attractionsRoutes = require('./routes/attractions.js');
// const moviesRoutes = require('./routes/movies.js');
// const outreachRoutes = require('./routes/outreach.js');
// const newsRoutes = require('./routes/news.js');
// const notificationsRoutes = require('./routes/notifications.js');
// const bookingsRoutes = require('./routes/bookings.js');
// const authMiddleware = require('./middleware/auth.middleware.js');


// require('dotenv').config();
// const app = express();

// app.use(express.json());

// Public Routes

// app.use('/api/quick-booking', quickBookingRoutes);
// app.use('/api/movies', moviesRoutes);
// app.use('/api/movies/all', moviesRoutes);
// app.use('/api/entry-tickets', bookingRoutes);
// app.use('/api/parking-options', bookingRoutes);
// app.use('/api/movies', bookingRoutes);
// app.use('/api/attractions', bookingRoutes);
// app.use('/api/booking', bookingRoutes)
// app.use('/api/outreach/all', outreachRoutes);
// app.use('/api/outreach/latest', outreachRoutes);
// app.use('/api/attractions/all', attractionsRoutes);
// app.use('/api/attractions/latest', attractionsRoutes);
// app.use('/api/news/latest', newsRoutes);
// app.use('/api/news/all', newsRoutes);

// Routes
// app.use('/api/auth', authRoutes);
// app.use('/api/entry-tickets/booking', entryTicketsRoutes);
// app.use('/api/parking/booking', parkingOptionsRoutes);
// app.use('/api/attractions/booking', bookingsRoutes);
// app.use('/api/attractions', attractionsRoutes);
// app.use('/api/attractions/latest', attractionsRoutes);
// app.use('/api/movies', moviesRoutes);
// app.use('/api/movies/latest', moviesRoutes);
// app.use('/api/news', newsRoutes);
// app.use('/api/news/latest', newsRoutes);
// app.use('/api/outreach', outreachRoutes);
// app.use('/api/outreach/latest', outreachRoutes);

// Protected Routes (JWT)
// app.use('/api/notifications', authMiddleware ,notificationsRoutes);
// app.use('/api/booking/summary/:userId', authMiddleware ,bookingsRoutes);
// app.use('/api/booking/confirm', authMiddleware, bookingsRoutes);

// --- HEALTHCHECK ---
// app.get('/api/health', (req, res) => res.json({ status: 'OK' }));

// Global Error Handler
// app.use(errorHandler);
// app.use((err, req, res, next) => {
//   console.error(err);
//   res.status(err.status || 500).json({ message: err.message || 'Server error' });
// });

const PORT = process.env.PORT || 3000;

// app.get('/', (req, res) => res.send('🟢 Backend running'));
// app.use((req, res) => res.status(404).json({ error: 'Not found' }));

app.listen(PORT, '0.0.0.0', () => {
  console.log(`Server running on http://0.0.0.0:${PORT}`);
});
// app.listen(PORT, () => console.log(`🟢 Server running on port ${PORT}`));


  // "scripts": {
  //   "start": "node server.js",
  //   "postinstall": "npx prisma generate && npx prisma db push"
  // },