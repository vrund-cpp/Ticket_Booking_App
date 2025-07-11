jest.mock('@prisma/client');
const request = require("supertest");
const app = require("../../app");
const jwt = require("jsonwebtoken");

jest.setTimeout(10000); // just in case

describe("🎟 Booking Controller", () => {
  let token;

  beforeAll(() => {
    token = jwt.sign(
      { userId: "mock-user-id" },
      process.env.JWT_SECRET || "your-secret",
      { expiresIn: "1h" }
    );
  });

  it("✅ should create a booking", async () => {
    const res = await request(app)
      .post("/api/bookings")
      .set("Authorization", `Bearer ${token}`)
      .send({
        userId: "mock-user-id",
              attractionId: "mock-attraction-id",
      date: "2025-07-15",
      slot: "10:00 AM - 12:00 PM",
      totalTickets: 2,
      });

    // ✅ These are the only valid responses we expect — no 401 anymore
expect(res.statusCode).toBe(200);
expect(res.body).toHaveProperty("message");
  });

  it("✅ should get user bookings", async () => {
    const res = await request(app)
      .get("/api/bookings/user")
      .set("Authorization", `Bearer ${token}`);

    expect(res.statusCode).toBe(200);
expect(res.body).toBeDefined();
    expect(Array.isArray(res.body)).toBe(true);
  });
});
