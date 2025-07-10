// backend/src/middleware/auth.middleware.js
const jwt = require('jsonwebtoken');
const prisma = require('../utils/db');

const secret = process.env.JWT_SECRET || "your-secret";

const authMiddleware = async (req, res, next) => {
  const auth = req.headers.authorization;
  if (!auth || !auth.startsWith('Bearer ')) {
    return res.status(401).json({ message: 'Missing token' });
  }
  // const token = auth.slice(7);
  const token = auth.split(' ')[1];
  try {
    const payload = jwt.verify(token, secret);
    if (!payload.userId) {
      return res.status(401).json({ message: 'Token missing userId' });
    }
    // req.userId = payload.userId;
    const user = await prisma.user.findUnique({
      where: { id: payload.userId }
    });
    if (!user) {
      return res.status(401).json({ message: 'Invalid token user' });
    }
    req.user = user; // ✅ THIS IS CRITICAL

    next();
  } catch (err) {
    console.error('JWT error:', err.message);
    res.status(401).json({ message: 'Unauthorized' });
  }
};

module.exports = authMiddleware;
