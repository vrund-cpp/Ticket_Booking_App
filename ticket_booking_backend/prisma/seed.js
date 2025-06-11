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
        imageUrl: 'https://example.com/movie1.jpg',
        releaseDate: new Date('2025-01-01'),
      },
      {
        title: 'Galactic Mission',
        description: 'A spiritual drama about purpose.',
        imageUrl: 'https://example.com/movie2.jpg',
        releaseDate: new Date('2025-02-10'),
      }
    ]
  });

  console.log('🎬 Movies seeded');

  // Seed Attractions
  await prisma.attraction.createMany({
    data: [
      {
        title: 'Science City',
        description: 'Explore science in a fun way!',
        imageUrl: 'https://example.com/sciencecity.jpg',
      },
      {
        title: 'Heritage Walk',
        description: 'Discover ancient architecture.',
        imageUrl: 'https://example.com/heritagewalk.jpg',
      }
    ]
  });

  console.log('📍 Attractions seeded');

  // Seed Outreach
  await prisma.outreach.createMany({
    data: [
      {
        title: 'Blood Donation Drive',
        description: 'Donate blood, save lives.',
        imageUrl: 'https://example.com/blooddrive.jpg',
        Startdate: new Date('2025-06-15'),
        Enddate: new Date('2025-06-17'),
      },
      {
        title: 'Free Health Camp',
        description: 'Donate blood, save lives.',
        imageUrl: 'https://example.com/healthcamp.jpg',
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
