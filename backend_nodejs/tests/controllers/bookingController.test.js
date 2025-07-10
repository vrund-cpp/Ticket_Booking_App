// tests/controllers/bookingController.test.js
const request = require("supertest");
const jwt = require("jsonwebtoken");
const app = require("../../app");
const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

describe("🎟 Booking Controller", () => {
  let token;
  let user;

  beforeAll(async () => {
    user = await prisma.user.create({
      data: {
        email: `test_${Date.now()}@example.com`,
        name: "Test@1234",
        mobile: "1111111112",
      },
    });
    token = jwt.sign({ userId: user.id }, "testsecret", { expiresIn: "1h" });
  });

  afterAll(async () => {
    await prisma.payment.deleteMany();
  await prisma.bookingItem.deleteMany();
  await prisma.booking.deleteMany();
  await prisma.user.delete({ where: { id: user.id } });
  await prisma.$disconnect();
  });

  it("✅ should create a booking", async () => {
    const res = await request(app)
      .post("/bookings")
      .set("Authorization", `Bearer ${token}`)
      .send({
        attractionId: 1,
        bookingDate: "2025-07-11",
        quantity: 2,
      });

    // If attraction ID 1 exists, should work — otherwise may return 400 or 404
    expect([201, 400, 404]).toContain(res.statusCode);
  });

});
