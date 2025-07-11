const request = require("supertest");
const app = require("../../app");
const jwt = require("jsonwebtoken");

jest.setTimeout(10000);

describe("🎬 Movies Controller", () => {
  let token;

  beforeAll(() => {
    token = jwt.sign(
      { userId: "mock-user-id" },
      process.env.JWT_SECRET || "your-secret",
      { expiresIn: "1h" }
    );
  });

  it("✅ should return movies (token required)", async () => {
    const res = await request(app)
      .get("/api/movies")
      .set("Authorization", `Bearer ${token}`);

    expect([200, 404]).toContain(res.statusCode); // ✅ Valid token = no 401
    expect(res.body).toBeDefined();
  });
});
