module.exports = {
  testEnvironment: 'node',
  testMatch: ["**/tests/**/*.test.js"],
  collectCoverage: true,
  coverageDirectory: "coverage",
  detectOpenHandles: true,
  forceExit: true,
  coverageThreshold: {
    global: {
      branches: 80,
      functions: 80,
      lines: 80,
      statements: 80
    }
  },
  moduleNameMapper: {
  '^@/utils/db$': '<rootDir>/__mocks__/src/utils/db.js',
  '^../../src/utils/db$': '<rootDir>/__mocks__/src/utils/db.js',
  '^../utils/db$': '<rootDir>/__mocks__/src/utils/db.js',  // ✅ Add this
    '^nodemailer$': '<rootDir>/__mocks__/nodemailer.js',
  },
};
