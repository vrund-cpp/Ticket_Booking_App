// tests/controllers/authController.test.js
jest.mock("../../src/utils/db"); // ✅ Ensure correct path

jest.mock("nodemailer", () => ({
  createTransport: () => ({
    sendMail: jest.fn().mockResolvedValue({ accepted: ["test@example.com"] }),
  }),
}));

jest.mock("../../src/services/otp.service", () => ({
  generateOtp: jest.fn(() => "1234"),
  saveOtp: jest.fn(() => Promise.resolve()),
  verifyOtp: jest.fn(() => Promise.resolve(true)),
}));

const prisma = require("../../src/utils/db");
const request = require("supertest");
const app = require("../../app"); // ensure index.js exports app

describe("🧪 AUTH CONTROLLER TESTS", () => {
  jest.setTimeout(30000);

    const testUser = {
    name: "Test User",
    email: "seed2@inboxkitten.com",
    mobile: "1234567890",
  };
beforeAll(async () => {
  await request(app).post("/api/auth/signup").send(testUser);
});

  afterAll(async () => {
    await prisma.$disconnect();
    jest.clearAllTimers(); 
  });

it("✅ /auth/signup should register user", async () => {
  const res = await request(app)
    .post("/api/auth/signup")
    .send(testUser);

  // Accept 200 or 409 (if user already registered)
  expect([200, 409]).toContain(res.statusCode);
});

  it("✅ /auth/login should login user", async () => {
    const res = await request(app)
      .post("/api/auth/login")
      .send({
        email: testUser.email,
      });

    console.log("🧪 Response:", res.body);
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
