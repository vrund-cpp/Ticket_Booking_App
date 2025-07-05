# ⚙️ TicketEase Backend – RESTful API Server

> Node.js + Express + PostgreSQL + Prisma  
> Secure, modular, and production-ready backend for TicketEase mobile app

---

## ⚙️ Overview

TicketEase Backend is a fully RESTful API server for handling:

- 🔐 OTP-based Authentication
- 🎫 Ticket Bookings (movies, parking, entry, attractions)
- 🔔 Notifications (CRUD + read count)
- 👤 Profile management (view/edit)
- 💳 Payment simulation
- 🧩 Prisma-powered relational DB

---

## 🚀 Quick Start

```bash
# Clone the repo
git clone https://github.com/your-username/ticketease.git
cd backend_nodejs/

# Install dependencies
npm install

# Setup environment
cp .env.example .env
# Fill in DB credentials and secrets

# Migrate & Seed DB
npx prisma migrate dev
node prisma/seed.js

# Start server
npm run dev

---

## 📁 Project Structure

backend_nodejs/
├── controllers/       # All business logic (auth, bookings, etc.)
├── routes/            # Route-level declarations
├── middleware/        # JWT verification, error handling
├── prisma/
│   ├── schema.prisma  # DB schema
│   └── seed.js        # Demo data script
├── .env.example       # Env vars template
├── app.js             # Express app setup
└── server.js          # Entry point


## 🌱 .env Example

DATABASE_URL="postgresql://user:password@dpg-d1j5hmmr433s73fsgo3g-a.oregon-postgres.render.com/db_name"
EMAIL_USER="tempuser@gmail.com"
EMAIL_PASS= Gmail App Password  // not use actual gmail password
JWT_SECRET= 128 characters jwt secret key
JWT_EXPIRES_IN=7d
PORT=3000


## 🧾 API Endpoints

| Method | Endpoint                      | Auth | Description                   |
| ------ | ----------------------------- | ---- | ----------------------------- |
| POST   | /auth/request-otp             | ❌    | Request OTP for login/signup  |
| POST   | /auth/signup                  | ❌    | Signup and receive user token |
| POST   | /auth/verify-otp              | ❌    | Verify OTP & receive JWT      |
| GET    | /movies                       | ✅    | Fetch all movies              |
| GET    | /movies/latest                | ✅    | Top 5 movies for dashboard    |
| GET    | /entry-tickets                | ✅    | Get entry ticket categories   |
| GET    | /attractions                  | ✅    | Fetch attractions             |
| GET    | /parking-options              | ✅    | List parking slots            |
| POST   | /bookings                     | ✅    | Create booking                |
| POST   | /payments                     | ✅    | Simulate payment              |
| GET    | /notifications                | ✅    | Get all notifications         |
| GET    | /notifications/count          | ✅    | Get unread notification count |
| PUT    | /notifications/mark-read/:id | ✅    | Mark single notification read |
| POST   | /notifications/mark-all-read  | ✅    | Mark all notifications read   |
| GET    | /profile                      | ✅    | View profile                  |
| PUT    | /profile                      | ✅    | Edit profile                  |


## 🧬 Prisma DB Schema

model User {
  id        String   @id @default(uuid())
  name      String
  mobile    String   @unique
  bookings  Booking[]
  notifications Notification[]}

model Booking {
  id        String   @id @default(uuid())
  userId    String
  type      String
  count     Int
  amount    Float
  user      User     @relation(fields: [userId], references: [id])}

model Notification {
  id      String  @id @default(uuid())
  userId  String
  message String
  isRead  Boolean
  user    User    @relation(fields: [userId], references: [id])}

Full schema: /prisma/schema.prisma


## 📤 Postman Collection
✅ Includes success + failure test cases
Import: TicketEase.postman_collection.json
Use Bearer Token for protected routes


## 🧠 Design Considerations
Uses JWT middleware for secured routes
Prisma ensures type-safe DB operations
Modular controllers for scalability
Logs errors gracefully
Seed data enables demo mode


## 👨‍💻 Developed By
Your Name
📧 your.email@example.com
🔗 LinkedIn
🔗 GitHub


## 📜 License
Open-sourced under the MIT License

