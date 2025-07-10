require("dotenv").config({ path: ".env.test" });

const jwtUtils = require("../../src/utils/jwt");

describe("🛡 JWT Utils", () => {
  it("should generate token", () => {
    const token = jwtUtils.generateToken({ userId: 1 });
    expect(token).toBeDefined();
  });

  it("should verify token", () => {
    const token = jwtUtils.generateToken({ userId: 1 });
    const decoded = jwtUtils.verifyToken(token);
    expect(decoded).toHaveProperty("userId", 1);
  });
});
