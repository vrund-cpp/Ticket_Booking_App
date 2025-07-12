require('dotenv').config({ path: '.env.test' }); // create if needed
process.env.JWT_SECRET = 'test_secret';
jest.mock('../../src/utils/db'); // ✅ This matches ../utils/db
jest.mock('../../src/services/email.service', () => ({
  sendEmail: jest.fn(),
}));
jest.mock('../../src/services/otp.service', () => ({
  generateOtp: jest.fn(() => '123456'),
  saveOtp: jest.fn(),
  verifyOtp: jest.fn(),
}));

const authController = require('../../src/controllers/authController');
const prisma = require('../../src/utils/db');
const { sendEmail } = require('../../src/services/email.service');
const { verifyOtp } = require('../../src/services/otp.service');

const httpMocks = require('node-mocks-http');
const jwt = require('jsonwebtoken');
process.env.JWT_SECRET = 'testsecret'; // for token

describe('🧪 Auth Controller', () => {
beforeEach(() => {
  // reset all mocks
  Object.values(prisma.user).forEach(fn => fn.mockReset());
  sendEmail.mockReset();
  verifyOtp.mockReset();
});

  describe('POST /signup', () => {
    it('should return 400 for invalid email or mobile', async () => {
      const req = httpMocks.createRequest({
        method: 'POST',
        body: { name: 'Test', email: 'invalid', mobile: '123' },
      });
      const res = httpMocks.createResponse();

      await authController.signup(req, res);
      expect(res.statusCode).toBe(400);
    });

    it('should return 409 if user already exists', async () => {
      prisma.user.findFirst.mockResolvedValue({ id: 1 });
      const req = httpMocks.createRequest({
        method: 'POST',
        body: { name: 'User', email: 'user@example.com', mobile: '9999999999' },
      });
      const res = httpMocks.createResponse();

      await authController.signup(req, res);
      expect(res.statusCode).toBe(409);
    });

    it('should create user and send OTP', async () => {
      prisma.user.findFirst.mockResolvedValue(null);
      prisma.user.create.mockResolvedValue({ id: 1 });
      const req = httpMocks.createRequest({
        method: 'POST',
        body: { name: 'User', email: 'user@example.com', mobile: '9999999999' },
      });
      const res = httpMocks.createResponse();

      await authController.signup(req, res);
      expect(sendEmail).toHaveBeenCalledWith('user@example.com', '123456');
      expect(res.statusCode).toBe(200);
    });
  });

  describe('POST /login', () => {
    it('should return 404 if user not found', async () => {
      prisma.user.findUnique.mockResolvedValue(null);
      const req = httpMocks.createRequest({
        method: 'POST',
        body: { email: 'notfound@example.com' },
      });
      const res = httpMocks.createResponse();

      await authController.login(req, res);
      expect(res.statusCode).toBe(404);
    });

    it('should send OTP if user exists', async () => {
      prisma.user.findUnique.mockResolvedValue({ id: 2, email: 'a@b.com' });
      const req = httpMocks.createRequest({
        method: 'POST',
        body: { email: 'a@b.com' },
      });
      const res = httpMocks.createResponse();

      await authController.login(req, res);
      expect(sendEmail).toHaveBeenCalledWith('a@b.com', '123456');
      expect(res.statusCode).toBe(200);
    });
  });

  describe('POST /request-otp', () => {
    it('should return 400 for missing identifier', async () => {
      const req = httpMocks.createRequest({ method: 'POST', body: {} });
      const res = httpMocks.createResponse();

      await authController.requestOtp(req, res);
      expect(res.statusCode).toBe(400);
    });

    it('should return 400 for invalid identifier', async () => {
      const req = httpMocks.createRequest({
        method: 'POST',
        body: { identifier: 'invalid' },
      });
      const res = httpMocks.createResponse();

      await authController.requestOtp(req, res);
      expect(res.statusCode).toBe(400);
    });

    it('should send OTP if valid email', async () => {
      const req = httpMocks.createRequest({
        method: 'POST',
        body: { identifier: 'valid@email.com' },
      });
      const res = httpMocks.createResponse();

      await authController.requestOtp(req, res);
      expect(sendEmail).toHaveBeenCalledWith('valid@email.com', '123456');
      expect(res.statusCode).toBe(200);
    });
  });

  describe('POST /verify-otp', () => {
    it('should return 400 for missing fields', async () => {
      const req = httpMocks.createRequest({ method: 'POST', body: {} });
      const res = httpMocks.createResponse();

      await authController.verifyOtpctrl(req, res);
      expect(res.statusCode).toBe(400);
    });

    it('should return 401 for invalid OTP', async () => {
      verifyOtp.mockResolvedValue(false);
      const req = httpMocks.createRequest({
        method: 'POST',
        body: { identifier: 'valid@email.com', otp: '123456' },
      });
      const res = httpMocks.createResponse();

      await authController.verifyOtpctrl(req, res);
      expect(res.statusCode).toBe(401);
    });

    it('should verify user and return token', async () => {
      verifyOtp.mockResolvedValue(true);
      prisma.user.findFirst.mockResolvedValue({ id: 1, email: 'valid@email.com' });
      console.log('🧪 is findFirst defined?', prisma.user.findFirst);
      prisma.user.updateMany.mockResolvedValue();
      prisma.user.update.mockResolvedValue();

      const req = httpMocks.createRequest({
        method: 'POST',
        body: { identifier: 'valid@email.com', otp: '123456' },
      });
      const res = httpMocks.createResponse();

      await authController.verifyOtpctrl(req, res);

      const json = res._getJSONData();
      expect(json).toHaveProperty('token');
      expect(res.statusCode).toBe(200);
    });
  });
});
