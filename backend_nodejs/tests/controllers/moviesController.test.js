jest.mock('../../src/utils/db'); // 👈 ensures Prisma is mocked

const request = require('supertest');
const express = require('express');
const moviesRouter = require('../../src/routes/movies');
const prisma = require('../../src/utils/db');

// Mock authMiddleware to skip real JWT logic
jest.mock('../../src/middleware/auth.middleware', () => (req, res, next) => {
  req.user = { id: 1, email: 'test@example.com' }; // simulate a logged-in user
  next();
});
const authMiddleware = require('../../src/middleware/auth.middleware');

const app = express();
app.use(express.json());
app.use('/api/movies', authMiddleware, moviesRouter);

describe('🎬 Movies Controller', () => {
  beforeEach(() => {
    jest.clearAllMocks();
  });

  describe('GET /api/movies/latest', () => {
    it('should return top 5 latest movies', async () => {
      const mockMovies = Array.from({ length: 5 }, (_, i) => ({
        id: i + 1,
        title: `Movie ${i + 1}`,
        releaseDate: new Date().toISOString()
      }));
      prisma.movie.findMany.mockResolvedValue(mockMovies);

      const res = await request(app).get('/api/movies/latest');

      expect(res.statusCode).toBe(200);
      expect(res.body).toHaveLength(5);
      expect(res.body[0]).toHaveProperty('title');
      expect(prisma.movie.findMany).toHaveBeenCalledWith({
        orderBy: { releaseDate: 'desc' },
        take: 5
      });
    });
  });

  describe('GET /api/movies', () => {
    it('should return all movies', async () => {
      const mockMovies = [
        { id: 1, title: 'Movie A' },
        { id: 2, title: 'Movie B' }
      ];
      prisma.movie.findMany.mockResolvedValue(mockMovies);

      const res = await request(app).get('/api/movies');

      expect(res.statusCode).toBe(200);
      expect(res.body).toHaveLength(2);
      expect(res.body[0].title).toBe('Movie A');
    });

    it('should return empty array with message if no movies found', async () => {
      prisma.movie.findMany.mockResolvedValue([]);

      const res = await request(app).get('/api/movies');

      expect(res.statusCode).toBe(200);
      expect(res.body).toEqual({ message: 'No movies found', data: [] });
    });
  });
});
