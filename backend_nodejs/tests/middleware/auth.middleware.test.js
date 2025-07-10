// tests/middleware/auth.middleware.test.js
const jwt = require("jsonwebtoken");
const request = require("supertest");
const app = require("../../app");

const validUserPayload = { userId: "test-user-id" };
const validToken = jwt.sign(validUserPayload, process.env.JWT_SECRET || "testsecret", { expiresIn: '1h' });

describe("🔐 Auth Middleware", () => {

  it("should block access without token", async () => {
    const res = await request(app).get("/api/bookings/user");
    expect(res.statusCode).toBe(401);
  });

  it("should block access with invalid token", async () => {
    const res = await request(app)
      .get("/api/bookings/user")
      .set("Authorization", `Bearer invalidtoken`);
    expect(res.statusCode).toBe(401);
  });

  it("should allow access with valid token", async () => {
    const res = await request(app)
      .get("/api/bookings/user")
      .set("Authorization", `Bearer ${validToken}`);
    
    // You may get 404 or other response if user 123 not exist — but auth middleware passes
    expect(res.statusCode).not.toBe(401);
    expect(res.statusCode).not.toBe(403);
  });
});
