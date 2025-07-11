// tests/services/otp.service.test.js
jest.mock('../../src/utils/db');
const otpService = require('../../src/services/otp.service');
const prisma = require('../../src/utils/db');

const crypto = require('crypto'); // ✅ Needed for hash comparison

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
    prisma.oTPRequest.create = jest.fn();

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

  it('✅ should return true if OTP matches', async () => {
    const hashed = otpService.hashOtp(otp);
    prisma.oTPRequest.findFirst = jest.fn().mockResolvedValue({ hashedOtp: hashed, expiresAt: new Date(Date.now() + 1000) });

    const result = await otpService.verifyOtp(identifier, otp);
    expect(result).toBe(true);
  });

  it('❌ should return false if OTP not found or expired', async () => {
    prisma.oTPRequest.findFirst = jest.fn().mockResolvedValue(null);

    const result = await otpService.verifyOtp(identifier, otp);
    expect(result).toBe(false);
  });
});
