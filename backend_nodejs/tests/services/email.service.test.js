require("dotenv").config({ path: ".env.test" });

jest.mock("../../src/services/email.service", () => ({
  sendMail: jest.fn(() => Promise.resolve({ accepted: ["test@example.com"] }))
}));


const sendMail = require("../../src/services/email.service");

describe("📧 Email Service", () => {
  it("should send mail (mocked)", async () => {
    const res = await sendMail("test@example.com", "Hello", "Test content");
    expect(res).toHaveProperty("accepted");
  });
});
