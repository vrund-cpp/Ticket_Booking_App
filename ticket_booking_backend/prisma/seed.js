const { PrismaClient } = require('@prisma/client');
const bcrypt = require('bcryptjs');
const prisma = new PrismaClient();

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

  console.log('🧹 Old data cleared');

  // Seed Users
  const user1 = await prisma.user.create({
    data: {
      name: 'Ravi Kumar',
      email: 'vrundleuva3@gmail.com',
      mobile: '9876543210',
      verified: true,
      notifications: {
        create: [
          {
            title: 'Welcome!',
            message: 'Thanks for joining the platform!',
          },
          {
            title: 'Update',
            message: 'New movie released this week!',
          }
        ]
      }
    }
  });

  const user2 = await prisma.user.create({
    data: {
      name: 'Priya Sharma',
      email: 'priya@example.com',
      mobile: '9123456789',
      verified: false,
    }
  });

  console.log('👥 Users created');

  // Seed OTP Requests
  const otp = '1234';
  const hashedOtp = await bcrypt.hash(otp, 10);

  await prisma.oTPRequest.create({
    data: {
      identifier: user1.mobile,
      hashedOtp,
      expiresAt: new Date(Date.now() + 10 * 60 * 1000), // Expires in 10 minutes
    }
  });

  console.log('🔐 OTPRequest created');

  // Seed Movies
  await prisma.movie.createMany({
    data: [
      {
        title: 'The Eternal Journey',
        description: 'A spiritual drama about purpose.',
        imageUrl: 'https://images.unsplash.com/photo-1744663122009-0f3d55946b54?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDR8Q0R3dXdYSkFiRXd8fGVufDB8fHx8fA%3D%3D',
        releaseDate: new Date('2025-01-01'),
        timeSlot: '10:00 AM',
        duration: 40,
        format: 'D2',
        language: 'Hindi',
        priceAdult: 80,
        priceKid: 40,
        priceSchool: 40,
      },
      {
        title: 'Galactic Mission',
        description: 'A spiritual drama about purpose.',
        imageUrl: 'https://images.unsplash.com/photo-1748370987492-eb390a61dcda?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDZ8Q0R3dXdYSkFiRXd8fGVufDB8fHx8fA%3D%3D',
        releaseDate: new Date('2025-02-10'),
        timeSlot: '11:00 AM',
        duration: 60,
        format: 'D3',
        language: 'English',
        priceAdult: 80,
        priceKid: 40,
        priceSchool: 40,
      },
      {
        title: 'Musical fountain',
        description: 'Gain the beautiful Experience',
        imageUrl: 'https://images.unsplash.com/photo-1735615479490-237b941e996a?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDJ8aVVJc25WdGpCMFl8fGVufDB8fHx8fA%3D%3D',
        releaseDate: new Date('2025-03-10'),        
        timeSlot: '12:00 AM',
        duration: 50,
        format: 'D2',
        language: 'Hindi',
        priceAdult: 80,
        priceKid: 40,
        priceSchool: 40,
      },
    ]
  });

  console.log('🎬 Movies seeded');

  // Seed Attractions
  await prisma.attraction.createMany({
    data: [
      {
        title: 'Science City',
        description: 'Explore science in a fun way!',
        imageUrl: 'https://images.unsplash.com/photo-1739118170165-9471f8be2dd6?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDJ8Q0R3dXdYSkFiRXd8fGVufDB8fHx8fA%3D%3D',
        priceAdult: 0, priceKid: 0, priceSchool: 10,
      },
      {
        title: 'Heritage Walk',
        description: 'Discover ancient architecture.',
        imageUrl: 'https://images.unsplash.com/photo-1658279165324-454de0ee3da6?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDN8Q0R3dXdYSkFiRXd8fGVufDB8fHx8fA%3D%3D',
        priceAdult: 0, priceKid: 30, priceSchool: 20
      },
      { title: 'Musical fountain', 
        description: 'Gain extraordinary Experience',
        imageUrl: 'https://images.unsplash.com/photo-1749746812881-c04e21eb1728?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxmZWF0dXJlZC1waG90b3MtZmVlZHwzOHx8fGVufDB8fHx8fA%3D%3D',
        priceAdult: 70, priceKid: 80, priceSchool: 0 
      },
    ]
  });

  console.log('📍 Attractions seeded');

  // Seed Outreach
  await prisma.outreach.createMany({
    data: [
      {
        title: 'Blood Donation Drive',
        description: 'Donate blood, save lives.',
        imageUrl: 'https://images.unsplash.com/photo-1713341516616-12ab673d4ea5?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDIwfENEd3V3WEpBYkV3fHxlbnwwfHx8fHw%3D',
        Startdate: new Date('2025-06-15'),
        Enddate: new Date('2025-06-17'),
      },
      {
        title: 'Free Health Camp',
        description: 'Donate blood, save lives.',
        imageUrl: 'https://plus.unsplash.com/premium_photo-1746363361912-fcbc9d8086ac?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDI1fENEd3V3WEpBYkV3fHxlbnwwfHx8fHw%3D',
        Startdate: new Date('2025-07-01'),
        Enddate: new Date('2025-07-02'),
      }
    ]
  });

  console.log('📢 Outreach events seeded');

  // Seed News
  await prisma.news.createMany({
    data: [
      {
        summary: 'Government launches new tech park.',
        date: new Date('2025-06-05'),
      },
      {
        summary: 'Heavy rainfall expected this week.',
        date: new Date('2025-06-06'),
      }
    ]
  });

  console.log('📰 News seeded');

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

  console.log('📰 parkingOption seeded');


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
