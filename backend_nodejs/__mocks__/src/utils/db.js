// ✅ __mocks__/src/utils/db.js
console.log("✅ __mocks__/src/utils/db.js loaded by Jest");

const mockUser = {
    id: "mock-user-id",
    name: "Test User",
    email: "seed2@inboxkitten.com",
    mobile: "1234567890",
    verified: true,
};

const mockBooking = {
    id: "mock-booking-id",
    userId: mockUser.id,
    attractionId: "mock-attraction-id",
    ticketCount: 2,
    bookingDate: new Date(),
};

const mockOtpRequest = {
    id: "mock-otp-id",
    identifier: "mock@example.com",
    otp: "1234",
    expiresAt: new Date(Date.now() + 5 * 60 * 1000), // 5 minutes later
};

const prisma = {
    user: {
    findUnique: jest.fn(({ where }) => {
      console.log("📦 Mock findUnique called with:", where);
      if (where.email === mockUser.email) {
        return Promise.resolve(mockUser);
      }
      return Promise.resolve(null);
    }),
    findFirst: jest.fn(({ where }) =>
      Promise.resolve(null)
    ),

    create: jest.fn(() =>
      Promise.resolve({ id:mockUser.id })
    ),

    update: jest.fn(() => Promise.resolve()),
    updateMany: jest.fn(() => Promise.resolve()),
  },

    booking: {
        create: jest.fn(() =>
            Promise.resolve({
                id: "mock-booking-id",
                userId: "mock-user-id",
                attractionId: "mock-attraction-id",
                date: new Date(),
                slot: "10:00 AM - 12:00 PM",
                totalTickets: 2,
                message: "Booking created successfully",
            })
        ),

        findMany: jest.fn(() =>
            Promise.resolve([
                {
                    id: "mock-booking-id",
                    userId: "mock-user-id",
                    attractionId: "mock-attraction-id",
                    date: new Date(),
                    slot: "10:00 AM - 12:00 PM",
                    totalTickets: 2,
                    message: "Booking fetched successfully",
                },
            ])
        ),
    },

    movie: {
        findMany: jest.fn(() =>
            Promise.resolve([
                {
                    id: "mock-movie-id",
                    title: "Mock Movie",
                    language: "English",
                    genre: "Action",
                    description: "Mock description",
                    releaseDate: new Date(),
                    imageUrl: "mock-thumbnail.png",
                },
            ])
        ),
    },

    oTPRequest: {
        create: jest.fn().mockResolvedValue(mockOtpRequest),
        findUnique: jest.fn(({ where }) => {
            console.log("💡 Mock user.findUnique() called with:", where);
            return Promise.resolve({
                id: "mock-user-id",
                email: where.email,
                name: "Mock User",
                phone: "9999999999",
            });
        }),
    },

    $disconnect: jest.fn(() => Promise.resolve()),
};

module.exports = prisma;
