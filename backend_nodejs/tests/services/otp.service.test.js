jest.mock('@prisma/client'); // 👈 this tells Jest to use your mock

const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient(); // 👈 this will use your mock

const otpService = require('../../src/services/otp.service');
const crypto = require('crypto');

describe('🔢 OTP Service', () => {
  const identifier = 'user@example.com';
  const otp = '1234';

  beforeEach(() => {
    jest.clearAllMocks();
  });

  it('🔒 should hash OTP using SHA-256', () => {
    const hash = otpService.hashOtp(otp);
    const expected = crypto.createHash('sha256').update(otp).digest('hex');
    expect(hash).toBe(expected);
  });

  it('✅ should save OTP in database', async () => {
    prisma.oTPRequest.create.mockResolvedValue({}); // ✅ Mock the method

    await otpService.saveOtp(identifier, otp);

    expect(prisma.oTPRequest.create).toHaveBeenCalledTimes(1);
    expect(prisma.oTPRequest.create).toHaveBeenCalledWith(expect.objectContaining({
      data: expect.objectContaining({
        identifier,
        hashedOtp: expect.any(String),
        expiresAt: expect.any(Date),
      }),
    }));
  });

  it('✅ should return true if OTP matches and not expired', async () => {
    const hashed = otpService.hashOtp(otp);
    prisma.oTPRequest.findFirst.mockResolvedValue({
      hashedOtp: hashed,
      expiresAt: new Date(Date.now() + 5 * 60 * 1000), // 5 min in future
    });

    const result = await otpService.verifyOtp(identifier, otp);
    expect(result).toBe(true);
  });

  it('❌ should return false if OTP not found or expired', async () => {
    prisma.oTPRequest.findFirst.mockResolvedValue(null); // ❌ not found

    const result = await otpService.verifyOtp(identifier, otp);
    expect(result).toBe(false);
  });
});
