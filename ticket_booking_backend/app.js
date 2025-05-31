const express = require('express');
const cors = require('cors');
const authRoutes = require('./src/routes/auth.routes.js');
require('dotenv').config();

const app = express();
app.use(cors());
app.use(express.json());

app.use('/api', authRoutes);

module.exports = app;
