// ✅ tests/services/email.service.test.js
const nodemailer = require('nodemailer');
const { sendEmail } = require('../../src/services/email.service');

jest.mock('nodemailer');

describe('📧 Email Service', () => {
  let mockSendMail;

  beforeEach(() => {
    mockSendMail = jest.fn().mockResolvedValue({ accepted: ['test@example.com'] });

    nodemailer.createTransport.mockReturnValue({
      sendMail: mockSendMail,
    });
  });

  it('✅ should send OTP email successfully', async () => {
    await sendEmail('test@example.com', '1234');

    expect(mockSendMail).toHaveBeenCalledTimes(1);
    expect(mockSendMail).toHaveBeenCalledWith(expect.objectContaining({
      to: 'test@example.com',
      subject: expect.stringContaining('OTP'),
      text: expect.stringContaining('1234'),
    }));
  });

  it('❌ should throw error if sendMail fails', async () => {
    mockSendMail.mockRejectedValue(new Error('Failed to send'));

    await expect(sendEmail('fail@example.com', '0000')).rejects.toThrow('Failed to send');
  });

  it('✅ should include correct subject and OTP', async () => {
    await sendEmail('test@example.com', '5678');

    const callArgs = mockSendMail.mock.calls[0][0];

    expect(callArgs.subject).toContain('OTP');
    expect(callArgs.text).toContain('5678');
  });
});
