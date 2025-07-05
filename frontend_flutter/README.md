```markdown
# 📱 TicketEase Frontend – Flutter Mobile App

> Full-Stack Multilingual Ticket Booking App  
> Built using Flutter + Node.js + PostgreSQL with 🔐 Auth, 🎬 Movie Tickets, 🚗 Parking, 🧍 Visitors & 🔔 Notifications  
> Developed as an internship project to demonstrate real-world, scalable, production-ready app development

---

## ✨ Key Highlights

- 🌐 Multilingual support – English 🇬🇧 & Hindi 🇮🇳
- 🔐 OTP-based authentication
- 🎫 Book movies, attractions, parking & entry tickets
- 👥 Visitor management
- 🧾 Booking history & simulated payment flow
- 🔔 Notifications with read/unread states
- 🧑‍💼 Profile view & update
- 📲 Push Notifications via Firebase
- 💡 Designed for scalability and real-world usage

---

## 🚀 Getting Started

```cmd
# Clone the repository
git clone https://github.com/your-username/ticketease.git
cd frontend_flutter

flutter clean

# Install dependencies
flutter pub get

# Run on connected device or emulator
flutter run

Make sure the backend server is running and connected

---

## 🏗️ Tech Stack

| Layer              | Technology                                | Purpose                                     |
|-------------------|--------------------------------------------|---------------------------------------------|
| Frontend          | Flutter 3.22.0                             | Cross-platform UI                           |
| Language          | Dart 3.8.0                                 | Null-safe, modern syntax                    |
| State Management  | Provider                                   | Efficient widget state sharing              |
| Routing           | GoRouter                                   | Declarative, dynamic navigation             |
| Local Storage     | SharedPreferences, FlutterSecureStorage    | Persist language settings & tokens          |
| Push Notifications| Firebase Messaging                         | Re-engagement and updates                   |
| Localization      | Easy_Localization                          | Language toggle at runtime                  |

---

## 🧾 Folder Structure

lib/
├── core/ # Configs, themes, constants
│ ├── config/ # Routing
│ ├── services/ # API/auth services
│ └── widgets/ # Shared custom widgets
├── features/ # Modular feature folders (booking, movies, notifications, etc.)
├── utils/ # JWT handling and helpers
├── data/ # Network + local storage logic
├── domain/ # Models/entities (clean architecture)
└── main.dart # Entry point

---

## 🌍 Language Support (i18n)
- Fully supports runtime switch between English & Hindi
- JSON-based translations using easy_localization

// assets/translations/en.json
{
  "login": "Login",
  "book_now": "Book Now"
}

// assets/translations/hi.json
{
  "login": "लॉग इन",
  "book_now": "बुक करें"
}

---

## 🔗 API Reference
- The app integrates with a secure backend (Node.js + Prisma).
- All interactions follow REST principles. Authenticated endpoints use JWT in headers.

GET    /movies             # Fetch all movies
POST   /bookings           # Submit booking
POST   /payments           # Simulate payment
GET    /profile            # Fetch user profile

Complete documentation in /backend_nodejs/README.md and Postman Collection.


## 🔐 Authentication Flow
Request OTP → Sign Up/Login
OTP Verification via backend
JWT Token storage via FlutterSecureStorage
All authenticated routes include Bearer Token in headers


## 🔐 Unique Decisions & Highlights

- Chose `Provider` for simplicity and easier onboarding in internship scope
- Used `Easy_Localization` with shared `.json` for clean multilingual support
- Used `GoRouter` for declarative navigation and nested routing support
- Notification system with count, mark-read, and list handling
- **Real-world UI/UX** approach: splash → language → login → dashboard → modules
- Domain-driven folder structure for scalable architecture (inspired by clean architecture)
- Future-proofed by separating core logic into `data`, `domain`, and `features`

---


## 🔮 Future Enhancements

- 💳 **Razorpay / Stripe payment gateway** integration
- 🧑‍💼 **Admin dashboard** for movie/outreach/news management
- 🌗 Dark mode toggle
- 🔌 Real-time updates via Firebase/Socket.io
- 📊 Booking analytics dashboard



🛠️ Developer Notes
Designed using clean architecture principles
Reusable widgets for booking cards, visitor forms, and cart logic
Error handling via try-catch & toast UI feedback
Maintains app state persistently


🙌 Contribution
This project is a part of my internship submission and is actively maintained.
Feel free to suggest enhancements via issues or PRs!


👨‍💻 Author
Developed by:

Your Name
📧 your.email@example.com
🔗 LinkedIn
🔗 GitHub


📜 License
This project is under the MIT License – use freely with credit 🙏