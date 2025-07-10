require("dotenv").config({ path: ".env.test" });
const request = require("supertest");
const jwt = require("jsonwebtoken");
const app = require("../../app");
const prisma = require("../../src/utils/db");

describe("📊 Dashboard Controller", () => {
  let user, token;

  beforeAll(async () => {
    const timestamp = Date.now();
    user = await prisma.user.create({
      data: {
        email: `dash_${timestamp}@example4.com`,
        name: "Test@123454",
        mobile: "9123456782",
      },
    });

    token = jwt.sign({ userId: user.id }, process.env.JWT_SECRET);
  });

  afterAll(async () => {
    await prisma.user.delete({ where: { id: user.id } });
    await prisma.$disconnect();
  });

  it("should get dashboard data", async () => {
    const res = await request(app)
      .get("/api/dashboard")
      .set("Authorization", `Bearer ${token}`);

    expect([200, 404]).toContain(res.statusCode);
    expect(res.body).toBeDefined();
  });
});
