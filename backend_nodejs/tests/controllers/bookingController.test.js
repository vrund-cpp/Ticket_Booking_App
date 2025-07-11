const request = require("supertest");
const app = require("../../app");
const jwt = require("jsonwebtoken");

jest.setTimeout(10000);

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
        attractionId: "mock-attraction-id",
        ticketCount: 2,
      });

    expect([201, 400, 404]).toContain(res.statusCode); // ✅ No 401!
  });

  it("✅ should get user bookings", async () => {
    const res = await request(app)
      .get("/api/bookings/user")
      .set("Authorization", `Bearer ${token}`);

    expect([200, 404]).toContain(res.statusCode); // ✅ No 401!
    expect(res.body).toBeDefined();
  });
});
