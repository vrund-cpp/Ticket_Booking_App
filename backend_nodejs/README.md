┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓  
┃           ⚙️ TICKETEASE BACKEND API           ┃  
┃     Scalable REST backend with PostgreSQL     ┃  
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛  

> “Build APIs like a product. Secure, documented, scalable.”  
> — *TicketEase Engineering Philosophy*

---

## 📘 Overview

The **TicketEase Backend** powers all core features of the TicketEase app via a secure, modular, and scalable **Node.js + Express** REST API using **Prisma ORM** and **PostgreSQL**.

🔐 OTP Auth | 🎫 Bookings | 🔔 Notifications | 👤 Profile | 💳 Payment | 🧩 DB Integrity

---

## 🚀 Quick Start

```bash
# 📥 Clone the repository
git clone https://github.com/vrund-cpp/Ticket_Booking_App
cd backend_nodejs/

# 📦 Install dependencies
npm install

# ⚙️ Setup environment variables
cp .env.example .env
# Edit .env with DB credentials, email config, JWT secrets

# 🛠️ Migrate & Seed the DB
npx prisma migrate dev
npx prisma db seed

# 🚀 Start development server
npm run dev

---

## 📁 Project Structure

backend_nodejs/
├── controllers/        # Business logic for each feature
├── routes/             # RESTful route definitions
├── middleware/         # JWT Auth, error handlers
├── prisma/             # DB schema + seed data
│   ├── schema.prisma
│   └── seed.js
├── .env.example        # Sample env config
├── app.js              # Express app init
└── server.js           # Entry point

---

## 🌱 .env Configuration
```env
DATABASE_URL="postgresql://user:password@host:port/db_name"
EMAIL_USER="your_email@gmail.com"
EMAIL_PASS="your_app_password"      # Use Gmail App Password, not main password
JWT_SECRET="your_128_char_jwt_secret"
JWT_EXPIRES_IN=7d
PORT=3000

---

## 🧾 API Endpoints
| Method | Endpoint                       | 🔒 Auth | Description                   |
| ------ | ------------------------------ | ------- | ----------------------------- |
| POST   | `/auth/request-otp`            | ❌       | Request OTP via mobile/email  |
| POST   | `/auth/signup`                 | ❌       | Signup & receive token        |
| POST   | `/auth/verify-otp`             | ❌       | Verify OTP & get JWT          |
| GET    | `/movies`                      | ✅       | List all movies               |
| GET    | `/movies/latest`               | ✅       | Top 5 movies for dashboard    |
| GET    | `/entry-tickets`               | ✅       | Entry ticket categories       |
| GET    | `/attractions`                 | ✅       | Attraction list               |
| GET    | `/parking-options`             | ✅       | Parking slots                 |
| POST   | `/bookings`                    | ✅       | Create a booking              |
| POST   | `/payments`                    | ✅       | Simulate payment flow         |
| GET    | `/notifications`               | ✅       | List user notifications       |
| GET    | `/notifications/count`         | ✅       | Get unread notification count |
| PUT    | `/notifications/mark-read/:id` | ✅       | Mark one notification as read |
| POST   | `/notifications/mark-all-read` | ✅       | Mark all notifications read   |
| GET    | `/profile`                     | ✅       | View logged-in user profile   |
| PUT    | `/profile`                     | ✅       | Update profile details        |


📖 Full API docs: TicketEase_API-docs.md
📬 Postman Collection: TicketEase.postman_collection.json

---

## 🧬 Prisma Schema (Sample)
```prisma

model User {
  id           String          @id @default(uuid())
  name         String
  mobile       String          @unique
  bookings     Booking[]
  notifications Notification[] 
}

model Booking {
  id       String   @id @default(uuid())
  userId   String
  type     String
  count    Int
  amount   Float
  user     User     @relation(fields: [userId], references: [id])
}

model Notification {
  id      String   @id @default(uuid())
  userId  String
  message String
  isRead  Boolean
  user    User     @relation(fields: [userId], references: [id])
}

📁 Full schema: prisma/schema.prisma

---

## ☁️ Hosting & Deployment
| Component     | Platform                         |
| ------------- | -------------------------------- |
| 🌐 API Server | [Render.com](https://render.com) |
| 🧮 Database   | Render PostgreSQL instance       |

---

## 📤 Postman Collection
### 📦 Ready-to-import TicketEase.postman_collection.json includes:
- ✅ Success scenarios
- ❌ Failure handling
- 🔐 Bearer token auth flow
- 🌐 Headers, payloads, and expected responses

---

### 🧠 Design Considerations
| ✅ Design Choice              | 📌 Reason                      |
| ---------------------------- | ------------------------------ |
| JWT Auth + Middleware        | Stateless, scalable, secure    |
| Prisma ORM                   | Type-safe DB operations        |
| Modular controllers & routes | Easy to scale and test         |
| Custom error middleware      | Clean error logs and responses |
| Seed script                  | Demo data for instant testing  |

---

## 👨‍💻 Developed By
Vrund Leuva
📧 vrundleuva3@gmail.com
🔗 LinkedIn
🔗 GitHub


## 📜 License
- This project is open-sourced under the MIT License — feel free to fork, learn, and build from it.
- Security Tip: Never expose .env files or real credentials in version control.


<p align="center"><strong>🛠️ Clean Code | 🔒 Secure Auth | 🚀 Scalable API | 🎯 Real-world Ready</strong></p> <p align="center"><em>— TicketEase Backend Engine</em></p> ```