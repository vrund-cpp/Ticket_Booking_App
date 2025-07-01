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

    console.log("🛒 Received booking request body:", req.body);

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

module.exports = { createBooking };


// const prisma = require('../utils/db.js');

// const createBooking =  async (req, res) => {
// try {
// const {
//   userId,
//   entryTickets = [],
//   parking = [],
//   attractionVisitorSlots = [],
//   movieVisitorSlots = [],
//   attractions = [],
//   movies = [],
//   total
// } = req.body;

// console.log("🛒 Received booking request body:", req.body);

// const booking = await prisma.booking.create({
// data: {
// userId,
// totalPrice: total,
// status: 'paid',
// items: {
// create: [
// ...entryTickets.map(e => ({
// type: 'entry_ticket',
// quantity: e.count,
// entryTicket: { connect: { id: e.id } },
// })),
// ...parking.map(p => ({
// type: 'parking',
// quantity: p.count,
// parkingOption: { connect: { id: p.id } },
// })),
// ...attractions.map(id => ({
// type: 'attraction',
// quantity: 1,
// attraction: { connect: { id } },
// })),
// ...movies.map(id => ({
// type: 'movie',
// quantity: 1,
// movie: { connect: { id } },
// })),
// ...attractionVisitorSlots.map(s => ({
// type: 'attraction',
// quantity: s.count,
// attraction: { connect: { id: s.id } },
// })),
// ...movieVisitorSlots.map(s => ({
// type: 'movie',
// quantity: s.count,
// movie: { connect: { id: s.id } },
// })),
// ]
// }
// }
// });
// console.log("✅ Booking created:", booking.id);
// res.status(201).json({ success: true, bookingId: booking.id });
// } catch (err) {
//   console.error('Booking Creation Failed:', err.message);
//   if (err.meta) console.error('Meta:', err.meta);
//   res.status(500).json({ success: false, error: 'Booking failed', details: err.message });
// }
// }
// module.exports = {createBooking};

// const confirmBooking = async (req, res) => {
// try {
// const { bookingId } = req.params;
// const booking = await prisma.booking.update({
// where: { id: bookingId },
// data: { status: 'CONFIRMED', paymentCompleted: true },
// });
// res.json({ success: true, booking });
// } catch (err) {
// console.error(err);
// res.status(500).json({ success: false, error: 'Booking confirmation failed' });
// }
// }



// const createBooking = async (req, res, next) => {
//   try {
//     const { userId, items } = req.body;

//     const booking = await prisma.booking.create({
//       data: {
//         userId,
//         totalPrice: items.reduce((sum, item) => sum + item.quantity * item.pricePerUnit, 0),
//         items: {
//           create: items.map(item => ({
//             type: item.type,
//             quantity: item.quantity,
//             pricePerUnit: item.pricePerUnit,
//             entryTicketId: item.entryTicketId || undefined,
//             parkingId: item.parkingId || undefined,
//             attractionId: item.attractionId || undefined,
//             movieId: item.movieId || undefined,
//           })),
//         },
//       },
//     });

//     res.status(201).json(booking);
//   } catch (error) {
//     next(error);
//   }
// };

// const getBookingById = async (req, res, next) => {
//   try {
//     const booking = await prisma.booking.findUnique({
//       where: { id: req.params.id },
//       include: {
//         items: true,
//       },
//     });

//     if (!booking) return res.status(404).json({ error: 'Booking not found' });

//     res.json(booking);
//   } catch (error) {
//     next(error);
//   }
// };

// const getBookingSummary = async (req, res) => {
//   const { userId } = req.params;

//   try {
//     const bookings = await prisma.booking.findFirst({
//       where: { userId },
//       orderBy: { createdAt: 'desc' },
//       include: {
//         items: {
//           include: {
//             entryTicket: true,
//             parkingOption: true,
//             attraction: true,
//             movie: true,
//           },
//         },
//       },
//     });


//     if (bookings.length === 0) {
//       return res.status(404).json({ message: 'No bookings found' });
//     }

    // if (!booking) return res.json({});

//     const latest = bookings[0];
//     res.json({
//       id: latest.id,
//       totalPrice: latest.totalPrice,
//       items: latest.items.map(i => ({
//         type: i.type,
//         quantity: i.quantity,
//         pricePerUnit: i.pricePerUnit,
//         title:
//           i.entryTicket?.name ||
//           i.parkingOption?.vehicleType ||
//           i.attraction?.title ||
//           i.movie?.title,
//       })),
//     });
//   } catch (error) {
//     console.error("Summary Error:", error);
//     res.status(500).json({ error: 'Failed to fetch summary' });
//   }
// };

// const createBooking = async (req, res) => {
//     const { userId } = req.params;
//     const { items } = req.body;

//   try {

//     const totalPrice = items.reduce(
//       (sum, item) => sum + item.quantity * item.pricePerUnit,
//       0
//     );

//     const booking = await prisma.booking.create({
//       data: {
//         userId,
//         totalPrice,
//         items: {
//           create: items.map(item => ({
//             type: item.type,
//             quantity: item.quantity,
//             pricePerUnit: item.pricePerUnit,
//             entryTicketId: item.entryTicketId || null,
//             parkingId: item.parkingId || null,
//             attractionId: item.attractionId || null,
//             movieId: item.movieId || null,
//           })),
//         },
//       },
//       include: {
//         items: true,
//       },
//     });

//     res.json(booking);
//   } catch (error) {
//     console.error("Booking Error:", error);
//     res.status(500).json({ error: 'Failed to create booking' });
//   }
// };


// module.exports = {getBookingSummary,createBooking};
