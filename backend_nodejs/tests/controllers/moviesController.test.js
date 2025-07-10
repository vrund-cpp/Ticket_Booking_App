require("dotenv").config({ path: ".env.test" });
const request = require("supertest");
const jwt = require("jsonwebtoken");
const app = require("../../app");
const prisma = require("../../src/utils/db");

describe("🎬 Movies Controller", () => {
  let user, token;

  beforeAll(async () => {
    const timestamp = Date.now();
    user = await prisma.user.create({
      data: {
        email: `test_${timestamp}@example1.com`,
        name: "Test@12341",
        mobile: "1234567891",
      },
    });

    token = jwt.sign({ userId: user.id }, process.env.JWT_SECRET);
  });

  afterAll(async () => {
    await prisma.user.delete({ where: { id: user.id } });
    await prisma.$disconnect();
  });

  it("should return movies (token required)", async () => {
    const res = await request(app)
      .get("/api/movies")
      .set("Authorization", `Bearer ${token}`);

    expect([200, 404]).toContain(res.statusCode);
    expect(res.body).toBeDefined();
  });
});
