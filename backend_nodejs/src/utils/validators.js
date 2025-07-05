const isValidEmail = (email) => {
  return /^[\w.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z]{2,10}(\.[a-zA-Z]{2,10})?$/.test(email);
}

const isValidMobile = (mobile) => {
  return /^[0-9]{10}$/.test(mobile);
}

module.exports = { isValidEmail, isValidMobile };
