// utils/jwt.js
const jwt = require('jsonwebtoken');

// const generateToken = (userId) => {
//   return jwt.sign({ userId }, process.env.JWT_SECRET, {
//     expiresIn: process.env.JWT_EXPIRES_IN,
//   });
// };

function generateToken(payload) {
  return jwt.sign(payload, process.env.JWT_SECRET || "defaultsecret", { expiresIn: "1h" });
}

function verifyToken(token) {
  return jwt.verify(token, process.env.JWT_SECRET || "defaultsecret");
}

module.exports = { generateToken ,verifyToken};
