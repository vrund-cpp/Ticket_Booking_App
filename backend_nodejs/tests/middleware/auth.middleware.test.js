const jwt = require("jsonwebtoken");
const request = require("supertest");
const app = require("../../app");

jest.setTimeout(10000); // ⏱️ prevent timeout

describe("🔐 Auth Middleware", () => {
  let token;

  beforeAll(() => {
    token = jwt.sign(
      { userId: "mock-user-id" },
      process.env.JWT_SECRET || "your-secret",
      { expiresIn: "1h" }
    );
  });

  it("✅ should allow access with valid token", async () => {
    const res = await request(app)
      .get("/api/dashboard") // ✅ safer fallback route
      .set("Authorization", `Bearer ${token}`);

    expect(res.statusCode).not.toBe(401);
    expect(res.statusCode).not.toBe(403);
  });
});
