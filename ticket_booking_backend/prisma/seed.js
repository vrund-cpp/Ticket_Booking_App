const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();
const bcrypt = require('bcrypt');
const { faker } = require('@faker-js/faker');

function imageUrl(query = '') {
  const id = Math.floor(Math.random() * 1000);
  return `https://picsum.photos/seed/${encodeURIComponent(query)}-${id}/800/600`;
}

async function generateOtpAndHash() {
  const otp = faker.number.int({ min: 1000, max: 9999 }).toString();
  const hash = await bcrypt.hash(otp, 10); // cost = 10 rounds
  return { otp, hash };
}

async function main() {

  // Clear old data (optional in dev)
  await prisma.notification.deleteMany();
  await prisma.user.deleteMany();
  await prisma.oTPRequest.deleteMany();
  await prisma.movie.deleteMany();
  await prisma.attraction.deleteMany();
  await prisma.outreach.deleteMany();
  await prisma.news.deleteMany();
  await prisma.bookingItem.deleteMany();
  await prisma.booking.deleteMany();
  await prisma.parkingOption.deleteMany();
  await prisma.entryTicket.deleteMany();
  await prisma.payment.deleteMany();

  console.log('🧹 Old data cleared');
  console.log("🌱 Starting seeding...");

  // 1. Seed Users
  const users = [];
  for (let i = 0; i < 7; i++) {
    const user = await prisma.user.create({
      data: {
        name: faker.person.fullName(),
        email: `seed${i + 1}@inboxkitten.com`,
        mobile: faker.phone.number('##########'),
        userType: faker.helpers.arrayElement(['adult', 'kid', 'school']),
        verified: faker.datatype.boolean()
      }
    });
    users.push(user);
  }
  console.log('👥 Users created');


  // Seed OTP Requests
  for (let user of users) {
    const { otp, hash } = await generateOtpAndHash();

    await prisma.oTPRequest.create({
      data: {
        identifier: user.email,
        hashedOtp: hash,
        expiresAt: new Date(Date.now() + 5 * 60 * 1000) // 1 minute
      }
    });

    console.log(`Generated OTP for ${user.email}: ${otp}`);
  }
  console.log('🔐 OTPRequest created');


  await prisma.entryTicket.createMany({
    data: [
      {
        name: "Adult",
        description: "People above 18 Years of age",
        price: 20,
        slotCount: 100,
        iconUrl: "https://cdn-icons-png.flaticon.com/512/3571/3571490.png"
      },
      {
        name: "kids",
        description: "Age between 8 to 18 years",
        price: 10,
        slotCount: 100,
        iconUrl: "https://cdn-icons-png.flaticon.com/512/3571/3571490.png"
      },
      {
        name: "Schools",
        description: "A min of 15 pax",
        price: 5,
        slotCount: 50,
        iconUrl: "https://cdn-icons-png.flaticon.com/512/2645/2645897.png"
      },

    ]
  });
  const entryTickets = await prisma.entryTicket.findMany();
  console.log('📰 EntryTicketItem seeded');


  // 3. Seed Parking Options
  await prisma.parkingOption.createMany({
    data: [
      {
        vehicleType: 'two_wheeler',
        price: 5,
        slotCount: 40,
        description: 'Scooter,Bike etc',
      },
      {
        vehicleType: 'four_wheeler',
        price: 10,
        slotCount: 30,
        description: 'Car & Passenger Vehicles',
      },
      {
        vehicleType: 'school_bus',
        price: 25,
        slotCount: 10,
        description: 'A min of 15 pax makes a group',
      }
    ]
  });
  const parkingOptions = await prisma.parkingOption.findMany();
  console.log('📰 parkingOption seeded');


  // 4. Attractions
  const attractions = await Promise.all(
    Array.from({ length: 7 }).map((_, i) =>
      prisma.attraction.create({
        data: {
          title: faker.commerce.productName(),
          description: faker.lorem.paragraph(),
          imageUrl: imageUrl('attraction'),
          priceAdult: faker.number.float({ min: 100, max: 200 }),
          priceKid: faker.number.float({ min: 50, max: 100 }),
          priceSchool: faker.number.float({ min: 40, max: 80 })
        }
      })
    )
  );


  // Seed Movies
  const movies = await Promise.all(
    Array.from({ length: 7 }).map(() =>
      prisma.movie.create({
        data: {
          title: faker.company.catchPhrase(),
          description: faker.lorem.paragraph(),
          imageUrl: imageUrl('movie'),
          releaseDate: faker.date.soon({ days: 15 }),
          timeSlot: `${faker.number.int({ min: 10, max: 20 })}:00`,
          duration: faker.number.int({ min: 90, max: 180 }),
          format: faker.helpers.arrayElement(['D2', 'D3']),
          language: faker.helpers.arrayElement(['English', 'Hindi', 'Gujarati', 'Tamil']),
          priceAdult: faker.number.float({ min: 100, max: 250 }),
          priceKid: faker.number.float({ min: 60, max: 100 }),
          priceSchool: faker.number.float({ min: 50, max: 90 })
        }
      })
    )
  );
  console.log('🎬 Movies seeded');


  // Seed Outreach
  await Promise.all(
    Array.from({ length: 7 }).map(() =>
      prisma.outreach.create({
        data: {
          title: faker.company.catchPhrase(),
          description: faker.lorem.sentences(2),
          imageUrl: imageUrl('event'),
          Startdate: faker.date.recent({ days: 10 }),
          Enddate: faker.date.soon({ days: 20 })
        }
      })
    )
  );
  console.log('📢 Outreach events seeded');


  // Seed News
  await Promise.all(
    Array.from({ length: 7 }).map(() =>
      prisma.news.create({
        data: {
          summary: faker.lorem.sentence(),
          date: faker.date.recent()
        }
      })
    )
  );
  console.log('📰 News seeded');


  // 8. Bookings (with Payment + Booking Items)
  for (const user of users) {
    const bookingStatus = faker.helpers.arrayElement(['pending', 'paid', 'failed', 'cancelled']);

    const booking = await prisma.booking.create({
      data: {
        userId: user.id,
        totalPrice: 0, // will update later
        status: bookingStatus
      }
    });

    const items = [];

    // Add entry_ticket
    if (Math.random() > 0.3) {
      const ticket = faker.helpers.arrayElement(entryTickets);
      items.push(await prisma.bookingItem.create({
        data: {
          bookingId: booking.id,
          type: 'entry_ticket',
          quantity: faker.number.int({ min: 1, max: 5 }),
          pricePerUnit: ticket.price,
          entryTicketId: ticket.id
        }
      }));
    }

    // Add parking
    if (Math.random() > 0.3) {
      const parking = faker.helpers.arrayElement(parkingOptions);
      items.push(await prisma.bookingItem.create({
        data: {
          bookingId: booking.id,
          type: 'parking',
          quantity: 1,
          pricePerUnit: parking.price,
          parkingId: parking.id
        }
      }));
    }

    // Add attraction
    if (Math.random() > 0.3) {
      const attraction = faker.helpers.arrayElement(attractions);
      items.push(await prisma.bookingItem.create({
        data: {
          bookingId: booking.id,
          type: 'attraction',
          quantity: 1,
          pricePerUnit: attraction.priceAdult,
          attractionId: attraction.id
        }
      }));
    }

    // Add movie
    if (Math.random() > 0.3) {
      const movie = faker.helpers.arrayElement(movies);
      items.push(await prisma.bookingItem.create({
        data: {
          bookingId: booking.id,
          type: 'movie',
          quantity: faker.number.int({ min: 1, max: 3 }),
          pricePerUnit: movie.priceAdult,
          movieId: movie.id
        }
      }));
    }

    // Calculate total price
    const total = items.reduce((acc, item) => acc + (item.quantity * item.pricePerUnit), 0);

    // Update booking total
    await prisma.booking.update({
      where: { id: booking.id },
      data: { totalPrice: total }
    });

    // Add payment if paid or failed
    if (bookingStatus !== 'pending' && bookingStatus !== 'cancelled') {
      await prisma.payment.create({
        data: {
          bookingId: booking.id,
          userId: user.id,
          amount: total,
          status: bookingStatus === 'paid' ? 'success' : 'failed',
          method: faker.helpers.arrayElement(['card', 'upi', 'netbanking']),
          transactionId: faker.string.uuid()
        }
      });
    }

    // Notifications
    await prisma.notification.create({
      data: {
        userId: user.id,
        title: bookingStatus === 'paid' ? 'Booking Confirmed' : 'Booking Failed',
        message: `Your booking is ${bookingStatus}. Total: ₹${total.toFixed(2)}`
      }
    });
  }




  console.log('✅ Seeding complete');
}

main()
  .catch((e) => {
    console.error('❌ Error during seeding:', e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
