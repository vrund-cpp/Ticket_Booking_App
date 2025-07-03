const prisma = require('../utils/db.js');

const createBooking = async (req, res) => {
  try {
    const { userId, items = [], totalPrice } = req.body;

    console.log("🛒 Received booking request:", req.body);

    if (!userId || !Array.isArray(items) || items.length === 0) {
      return res.status(400).json({ message: 'userId and items[] are required' });
    }

    // Group by type
    const entryTickets = items.filter(i => i.type === 'entry_ticket');
    const parking = items.filter(i => i.type === 'parking');
    const attractions = items.filter(i => i.type === 'attraction' && i.quantity === 1 && !i.pricePerUnit);
    const attractionVisitorSlots = items.filter(i => i.type === 'attraction' && i.pricePerUnit);
    const movies = items.filter(i => i.type === 'movie' && i.quantity === 1 && !i.pricePerUnit);
    const movieVisitorSlots = items.filter(i => i.type === 'movie' && i.pricePerUnit);

    // Fetch latest prices from DB for entry and parking
    const entryData = await prisma.entryTicket.findMany({
      where: { id: { in: entryTickets.map(e => e.entryTicketId) } },
      select: { id: true, price: true }
    });
    const entryPriceMap = Object.fromEntries(entryData.map(e => [e.id, e.price]));

    const parkingData = await prisma.parkingOption.findMany({
      where: { id: { in: parking.map(p => p.parkingId) } },
      select: { id: true, price: true }
    });
    const parkingPriceMap = Object.fromEntries(parkingData.map(p => [p.id, p.price]));

    const booking = await prisma.booking.create({
      data: {
        userId,
        totalPrice,
        status: 'paid',
        items: {
          create: [
            ...entryTickets.map(e => ({
              type: 'entry_ticket',
              quantity: e.quantity,
              pricePerUnit: entryPriceMap[e.entryTicketId] ?? e.pricePerUnit,
              entryTicket: { connect: { id: e.entryTicketId } },
            })),
            ...parking.map(p => ({
              type: 'parking',
              quantity: p.quantity,
              pricePerUnit: parkingPriceMap[p.parkingId] ?? p.pricePerUnit,
              parkingOption: { connect: { id: p.parkingId } },
            })),
            ...attractions.map(a => ({
              type: 'attraction',
              quantity: 1,
              pricePerUnit: 0,
              attraction: { connect: { id: a.attractionId } },
            })),
            ...attractionVisitorSlots.map(s => ({
              type: 'attraction',
              quantity: s.quantity,
              pricePerUnit: s.pricePerUnit,
              attraction: { connect: { id: s.attractionId } },
            })),
            ...movies.map(m => ({
              type: 'movie',
              quantity: 1,
              pricePerUnit: 0,
              movie: { connect: { id: m.movieId } },
            })),
            ...movieVisitorSlots.map(s => ({
              type: 'movie',
              quantity: s.quantity,
              pricePerUnit: s.pricePerUnit,
              movie: { connect: { id: s.movieId } },
            })),
          ]
        }
      }
    });

    console.log('✅ Booking created:', booking.id);
    res.status(201).json({ success: true, bookingId: booking.id });

  } catch (err) {
    console.error('❌ Booking error:', err);
    res.status(500).json({ message: 'Booking failed', error: err.message });
  }
};

module.exports = { createBooking };
