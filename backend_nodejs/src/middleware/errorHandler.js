// src/middleware/errorHandler.js

const errorHandler = (err, req, res, next) => {
  console.error(err); // Log the error for debugging
  const statusCode = err.statusCode || 500;
  const message = err.message || 'Internal Server Error';
  res.status(statusCode).json({ message });
};

module.exports = errorHandler;
