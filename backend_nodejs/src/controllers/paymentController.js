const prisma = require('../utils/db.js');
const { v4: uuidv4 } = require('uuid');

const createPayment = async (req, res) => {

  try {
    const { userId, bookingId, amount, method } = req.body;

    if (!userId || !amount) {
      return res.status(400).json({
        success: false,
        message: 'userId and totalamount are required'
      });
    }

    const payment = await prisma.payment.create({
      data: {
        userId,
        bookingId,
        amount,
        status: 'success',
        method,
        transactionId: uuidv4(),
      },
    });

    await prisma.booking.update({
      where: { id: bookingId },
      data: { status: 'paid' },
    });

    res.status(201).json({ success: true, payment });
  } catch (err) {
    console.error(err);
    res.status(500).json({ success: false, error: 'Payment failed' });
  }
};

module.exports = { createPayment };
