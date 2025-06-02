const express = require('express');
const cors = require('cors');
const authRoutes = require('./src/routes/auth.routes.js');
require('dotenv').config();

const app = express();

const { exec } = require('child_process');

app.get('/push-schema', async (req, res) => {
  exec('npx prisma db push', (err, stdout, stderr) => {
    if (err) {
      console.error(stderr);
      return res.status(500).send('Error pushing schema:\n' + stderr);
    }
    res.send('Schema pushed successfully:\n' + stdout);
  });
});

app.get('/push-schema', async (req, res) => {
  const { exec } = require('child_process');
  exec('npx prisma db push', (err, stdout, stderr) => {
    if (err) {
      console.error(stderr);
      return res.status(500).send('Error pushing schema');
    }
    res.send('Schema pushed successfully:\n' + stdout);
  });
});

app.use(cors());
app.use(express.json());

app.use('/api', authRoutes);

module.exports = app;
