const prisma = require('../utils/db.js');

const createBooking = async (req, res) => {

  try {
    const {
      userId,
      entryTickets = [],
      parking = [],
      attractionVisitorSlots = [],
      movieVisitorSlots = [],
      attractions = [],
      movies = [],
      total
    } = req.body;

    if (!userId || !total) {
      return res.status(400).json({
        success: false,
        message: 'userId and totalAmount are required'
      });
    }

    console.log("🛒 Received booking request body:", req.body);

        const items = [
      ...entryTickets,
      ...parking,
      ...attractions,
      ...movies,
      ...attractionVisitorSlots,
      ...movieVisitorSlots
    ];
    if (!Array.isArray(items) || items.length === 0) {
      return res.status(400).json({ message: 'Booking items are required' });
    }

    // 🔍 Fetch prices for entryTickets
    const entryTicketIds = entryTickets.map(e => e.id);
    const entryData = await prisma.entryTicket.findMany({
      where: { id: { in: entryTicketIds } },
      select: { id: true, price: true }
    });
    const entryPriceMap = Object.fromEntries(entryData.map(e => [e.id, e.price]));

    // 🔍 Fetch prices for parking
    const parkingIds = parking.map(p => p.id);
    const parkingData = await prisma.parkingOption.findMany({
      where: { id: { in: parkingIds } },
      select: { id: true, price: true }
    });
    const parkingPriceMap = Object.fromEntries(parkingData.map(p => [p.id, p.price]));

    const booking = await prisma.booking.create({
      data: {
        userId,
        totalPrice: total,
        status: 'paid',
        items: {
          create: [
            // ✅ Entry Tickets with correct prices
            ...entryTickets.map(e => ({
              type: 'entry_ticket',
              quantity: e.count,
              pricePerUnit: entryPriceMap[e.id] ?? 0,
              entryTicket: { connect: { id: e.id } },
            })),

            // ✅ Parking with correct prices
            ...parking.map(p => ({
              type: 'parking',
              quantity: p.count,
              pricePerUnit: parkingPriceMap[p.id] ?? 0,
              parkingOption: { connect: { id: p.id } },
            })),

            // ✅ Attractions (basic toggle type — price is 0)
            ...attractions.map(id => ({
              type: 'attraction',
              quantity: 1,
              pricePerUnit: 0,
              attraction: { connect: { id } },
            })),

            // ✅ Movies (basic toggle type — price is 0)
            ...movies.map(id => ({
              type: 'movie',
              quantity: 1,
              pricePerUnit: 0,
              movie: { connect: { id } },
            })),

            // ✅ Attraction Visitor Slots
            ...attractionVisitorSlots.map(s => ({
              type: 'attraction',
              quantity: s.count,
              pricePerUnit: s.pricePerUnit,
              attraction: { connect: { id: s.id } },
            })),

            // ✅ Movie Visitor Slots
            ...movieVisitorSlots.map(s => ({
              type: 'movie',
              quantity: s.count,
              pricePerUnit: s.pricePerUnit,
              movie: { connect: { id: s.id } },
            })),
          ]
        }
      }
    });

    console.log("✅ Booking created:", booking.id);
    res.status(201).json({ success: true, bookingId: booking.id });

  } catch (err) {
    console.error('❌ Booking Creation Failed:', err.message);
    if (err.meta) console.error('Meta:', err.meta);
    res.status(500).json({ success: false, error: 'Booking failed', details: err.message });
  }
};

const getUserBookings = async (req, res) => {
  try {
    const bookings = await prisma.booking.findMany({
      where: { userId: req.user.id },
      include: { items: true }
    });
    if (!bookings || bookings.length === 0) {
      return res.status(404).json({ message: 'No bookings found' });
    }
    res.status(200).json(bookings);
  } catch (err) {
    console.error("getUserBookings error:", err);
    res.status(500).json({ message: 'Server error' });
  }
};

module.exports = { createBooking,getUserBookings };