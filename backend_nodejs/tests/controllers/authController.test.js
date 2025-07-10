// tests/controllers/authController.test.js
const request = require("supertest");
const app = require("../../app"); // ensure index.js exports app
const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();


describe("🧪 AUTH CONTROLLER TESTS", () => {
  jest.setTimeout(30000);

    const testUser = {
    name: "test name10",
    email: `test_${Date.now()}@example10.com`,
    mobile: "1999999910",
  };

  afterAll(async () => {
    await prisma.$disconnect();
    jest.clearAllTimers(); 
  });

  it("✅ /auth/signup should register user", async () => {
    const res = await request(app)
      .post("/api/auth/signup")
      .send(testUser);

    expect(res.statusCode).toBe(200);
    expect(res.body).toHaveProperty("message");
  });

  it("✅ /auth/login should login user", async () => {
    const res = await request(app)
      .post("/api/auth/login")
      .send({
        email: "seed2@inboxkitten.com",
      });

    expect(res.statusCode).toBe(200);
    expect(res.body).toHaveProperty("message");
  });

  it("✅ /auth/request-otp should send OTP", async () => {
    const res = await request(app)
      .post("/api/auth/request-otp")
      .send({ identifier: testUser.email });

    expect(res.statusCode).toBe(200);
    expect(res.body).toHaveProperty("message");
  });

  it("✅ /auth/verify-otp should fail (invalid OTP)", async () => {
    const res = await request(app)
      .post("/api/auth/verify-otp")
      .send({ identifier: testUser.email, otp: "0000" });

   expect([400, 401]).toContain(res.statusCode); // assuming wrong OTP
  });
});
