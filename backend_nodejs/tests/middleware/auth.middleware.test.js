const jwt = require("jsonwebtoken");
const request = require("supertest");
const app = require("../../app");
const prisma = require("../../src/utils/db"); // ✅ Correct shared instance

describe("🔐 Auth Middleware", () => {
  let token;
  let testUser;

  beforeAll(async () => {
    const timestamp = Date.now();

    testUser = await prisma.user.create({
      data: {
        email: `test_${timestamp}@mail.com`,
        name: "AuthTestUser",
        mobile: `99999${timestamp.toString().slice(-5)}`
      },
    });

    token = jwt.sign({ userId: testUser.id }, process.env.JWT_SECRET || "your-secret", {
      expiresIn: "1h",
    });
  });

  afterAll(async () => {
    if (testUser?.id) {
      await prisma.user.delete({ where: { id: testUser.id } });
    }
    await prisma.$disconnect(); // ✅ Will now work correctly
  });

  it("✅ should allow access with valid token", async () => {
    const res = await request(app)
      .get("/api/profile") // Ensure this route exists
      .set("Authorization", `Bearer ${token}`);

    expect(res.statusCode).not.toBe(401);
    expect(res.statusCode).not.toBe(403);
  });
});
