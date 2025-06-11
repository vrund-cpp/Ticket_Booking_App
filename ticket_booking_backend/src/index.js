// File: backend/index.js

const express = require('express');
const cors =  require('cors');
const dotenv =  require('dotenv');

const authRoutes = require('./routes/auth.js');
const moviesRoutes = require('./routes/movies.js');
const outreachRoutes = require('./routes/outreach.js');
const attractionsRoutes = require('./routes/attractions.js');
const newsRoutes = require('./routes/news.js');
const notificationsRoutes = require('./routes/notifications.js');

const errorHandler = require('./middleware/errorHandler.js');

dotenv.config();
const app = express();


app.use(cors());
app.use(express.json());

// Public Routes
app.use('/api/auth', authRoutes);
// app.use('/api/quick-booking', quickBookingRoutes);
app.use('/api/movies', moviesRoutes);
app.use('/api/outreach', outreachRoutes);
app.use('/api/attractions', attractionsRoutes);
app.use('/api/news', newsRoutes);

// Protected Routes (JWT)
app.use('/api/notifications', notificationsRoutes);

// Global Error Handler
// app.use(errorHandler);

const PORT = process.env.PORT || 3000;

app.get('/', (req, res) => res.send('🟢 Backend running'));
app.use((req, res) => res.status(404).json({ error: 'Not found' }));

app.listen(PORT, '0.0.0.0', () => {
  console.log(`Server running on http://0.0.0.0:${PORT}`);
});
// app.listen(PORT, () => console.log(`🟢 Server running on port ${PORT}`));


  // "scripts": {
  //   "start": "node server.js",
  //   "postinstall": "npx prisma generate && npx prisma db push"
  // },