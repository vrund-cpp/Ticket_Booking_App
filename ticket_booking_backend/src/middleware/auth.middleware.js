// backend/src/middleware/auth.middleware.js
const jwt = require('jsonwebtoken');

const authMiddleware = (req, res, next) => {
  const auth = req.headers.authorization;
  if (!auth || !auth.startsWith('Bearer ')) {
    return res.status(401).json({ message: 'Missing token' });
  }
  const token = auth.slice(7);
  try {
    const payload = jwt.verify(token, process.env.JWT_SECRET);
    req.userId = payload.userId;
    next();
  } catch {
    res.status(401).json({ message: 'Invalid token' });
  }
};

module.exports = authMiddleware;
