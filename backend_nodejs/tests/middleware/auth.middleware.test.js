// tests/middleware/auth.middleware.test.js
const jwt = require("jsonwebtoken");
const request = require("supertest");
const app = require("../../app");
const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

describe("🔐 Auth Middleware", () => {

  let token;
  let testUser;

  beforeAll(async () => {
    const timestamp = Date.now();

    // 👤 Create real user in test DB
    testUser = await prisma.user.create({
      data: {
        email: `test_${timestamp}@mail.com`,
        name: "AuthTestUser",
        mobile: `99999${timestamp.toString().slice(-5)}`,
      },
    });

    // 🔐 Sign valid token with this user's id
    token = jwt.sign({ userId: testUser.id }, process.env.JWT_SECRET || "your-secret", {
      expiresIn: "1h",
    });
  });

  afterAll(async () => {
    if (testUser?.id) {
      await prisma.user.delete({ where: { id: testUser.id } });
    }
    await prisma.$disconnect();
  });

  it("✅ should allow access with valid token", async () => {
    const res = await request(app)
      .get("/api/profile") // 🔒 Must be a real route protected by auth middleware
      .set("Authorization", `Bearer ${token}`);

    // Allow any valid response except 401/403
    expect(res.statusCode).not.toBe(401);
    expect(res.statusCode).not.toBe(403);
  });
});
