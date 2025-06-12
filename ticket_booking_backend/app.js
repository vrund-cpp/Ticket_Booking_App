// const express = require('express');
// const cors = require('cors');
// const authRoutes = require('./src/routes/auth.js');
// require('dotenv').config();

// const app = express();
// const { PrismaClient } = require('@prisma/client');
// const prisma = new PrismaClient();

// app.set("trust proxy", 1); // trust first proxy


// // const { exec } = require('child_process');

// // app.get('/push-schema', async (req, res) => {
// //   exec('npx prisma db push', (err, stdout, stderr) => {
// //     if (err) {
// //       console.error(stderr);
// //       return res.status(500).send('Error pushing schema:\n' + stderr);
// //     }
// //     res.send('Schema pushed successfully:\n' + stdout);
// //   });
// // });

// // app.get('/push-schema', async (req, res) => {
// //   const { exec } = require('child_process');
// //   exec('npx prisma db push', (err, stdout, stderr) => {
// //     if (err) {
// //       console.error(stderr);
// //       return res.status(500).send('Error pushing schema');
// //     }
// //     res.send('Schema pushed successfully:\n' + stdout);
// //   });
// // });
// app.use(cors({ origin: true, credentials: true }));
// app.use(express.json());
// app.use('/api/auth', authRoutes);

// const moviesRoutes = require('./src/routes/movies');
// const outreachRoutes = require('./src/routes/outreach'); 
// const attractionsRoutes = require('./src/routes/attractions');
// const newsRoutes = require('./src/routes/news');
// const notificationsRoutes = require('./src/routes/notifications');


// app.use('/api/movies', moviesRoutes);
// app.use('/api/outreach', outreachRoutes);
// app.use('/api/attractions', attractionsRoutes);
// app.use('/api/news', newsRoutes);
// app.use('/api/notifications', notificationsRoutes);

// // ✅ Add this test route to check DB connection
// app.get('/push-schema', async (req, res) => {
//   try {
//     await prisma.$connect();
//     res.send('✅ Connected to DB and Prisma is working');
//   } catch (err) {
//     console.error(err);
//     res.status(500).send('❌ Error connecting to DB');
//   }
// });

// module.exports = app;
