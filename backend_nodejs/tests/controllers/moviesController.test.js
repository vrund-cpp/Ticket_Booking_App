const request = require("supertest");
const app = require("../../app");
const jwt = require("jsonwebtoken");

jest.setTimeout(10000);

describe("🎬 Movies Controller", () => {
  let token;

  beforeAll(() => {
    token = jwt.sign(
      { id: "mock-user-id" },
      "your-secret",
      { expiresIn: "1h" }
    );
  });

  it("✅ should return movies (token required)", async () => {
    const res = await request(app)
      .get("/api/movies")
      .set("Authorization", `Bearer ${token}`);

    // ✅ Only expecting valid responses — remove incorrect 401 expectation
expect(res.statusCode).toBe(200);
expect(res.body).toBeDefined();
expect(Array.isArray(res.body)).toBe(true);
  });
});
