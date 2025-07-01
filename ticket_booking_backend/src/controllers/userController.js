const prisma = require('../utils/db');

const getProfile = async (req, res) => {

  if (!req.user || !req.user.id) {
    return res.status(401).json({ message: 'Unauthorized – user not found' });
  }

const userId = req.user.id;

const user = await prisma.user.findUnique({
where: { id: userId },
select: { id: true, name: true, email: true, mobile: true },
});

const bookings = await prisma.booking.findMany({
where: { userId },
include: {
items: true,
},
orderBy: { createdAt: 'desc' },
});

const formatted = bookings.map(b => {
  console.log('👉 ITEM TYPES:', b.items.map(i => i.type));
  console.log('🧾 Items for booking:', b.items.map(i => ({
  type: i.type,
  price: i.pricePerUnit,
  qty: i.quantity
})));

const entryAmount = b.items
  .filter(i => i.type.toLowerCase() === 'entry_ticket')
  .reduce((sum, i) => sum + i.pricePerUnit * i.quantity, 0);

const parkingAmount = b.items
  .filter(i => i.type.toLowerCase() === 'parking')
  .reduce((sum, i) => sum + i.pricePerUnit * i.quantity, 0);

const attractionAmount = b.items
  .filter(i => i.type.toLowerCase() === 'attraction')
  .reduce((sum, i) => sum + i.pricePerUnit * i.quantity, 0);

const movieAmount = b.items
  .filter(i => i.type.toLowerCase() === 'movie')
  .reduce((sum, i) => sum + i.pricePerUnit * i.quantity, 0);

  // const entryAmount = b.items.filter(i => i.type === 'entry_ticket').reduce((sum, i) => sum + i.pricePerUnit * i.quantity, 0);
// const parkingAmount = b.items.filter(i => i.type === 'parking').reduce((sum, i) => sum + i.pricePerUnit * i.quantity, 0);
// const attractionAmount = b.items.filter(i => i.type === 'attraction').reduce((sum, i) => sum + i.pricePerUnit * i.quantity, 0);
// const movieAmount = b.items.filter(i => i.type === 'movie').reduce((sum, i) => sum + i.pricePerUnit * i.quantity, 0);
return {
  id: b.id,
  entryAmount,
  parkingAmount,
  attractionAmount,
  movieAmount,
  total: b.totalPrice,
  createdAt: new Date(b.createdAt).toLocaleDateString('en-IN', {
    day: '2-digit',
    month: 'long',
    year: 'numeric',
    weekday: 'long',
  }),
  status: b.status,
};
});

res.json({ user, bookings: formatted });
};

const updateProfile = async (req, res) => {
  try{
const userId = req.user.id;
const { name, email, mobile } = req.body;

const updatedUser = await prisma.user.update({
where: { id: userId },
data: { name, email, mobile },
});

res.status(200).json({ success: true, user: updatedUser });
  } catch (err) {
    console.error('❌ Failed to update profile:', err.message);
    res.status(500).json({ success: false, message: 'Update failed' });
  }
};

module.exports = {getProfile,updateProfile};