require("dotenv").config({ path: ".env.test" });
const otpService = require("../../src/services/otp.service");

describe("🔢 OTP Service", () => {
  it("should generate 4-digit OTP", () => {
    const otp = otpService.generateOtp();
    expect(otp).toMatch(/^\d{4}$/); // or \d{4} if you're using 4-digit
  });

  it("should fail verifyOTP without stored OTP", () => {
    const result = otpService.verifyOtp("some@email.com", "1234");
    expect(result).toBe(false);
  });
});
