┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓  
┃           📱 TICKETEASE FLUTTER APP           ┃  
┃     Scalable, multilingual, production UI     ┃  
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛  

> **"Built with Flutter. Designed for the real world."**

---

## ✨ Key Highlights

- 🗂️ Modular structure with `features/`, `core/`, `data/`, and `domain/`
- 🌐 i18n using `easy_localization` with runtime language switching
- 🔐 Secure token + language persistence via SecureStorage
- 🔁 Efficient state management with `Provider`
- 🧠 Real-world user flow: splash → login → book → dashboard → notify

---

## 🚀 Getting Started

```bash
# 📥 Clone the repo
git clone https://github.com/vrund-cpp/Ticket_Booking_App
cd frontend_flutter

# 🔄 Clean old builds
flutter clean

# 📦 Install dependencies
flutter pub get

# 🚀 Run the app (ensure backend is live)
flutter run
✅ Note: The backend must be running and connected to the correct base URL.

---

## 🏗️ Tech Stack
| Layer            | Tech                              | Purpose                          |
| ---------------- | --------------------------------- | -------------------------------- |
| 📱 UI            | Flutter 3.22.0                    | Cross-platform, fast UIs         |
| 🧠 Language      | Dart 3.8.0                        | Null-safe modern language        |
| 🔄 State Mgmt    | Provider                          | Reactive UI + app-wide state     |
| 🧭 Routing       | GoRouter                          | Declarative nested navigation    |
| 🔐 Storage       | SharedPreferences + SecureStorage | Persist language, token securely |
| 🔔 Notifications | Firebase Messaging                | Push alerts to users             |
| 🌍 Localization  | easy\_localization                | EN/HI toggle at runtime          |

---

## 🧾 Folder Structure
```bash

lib/
├── core/              # Global configs, routing, constants
│   ├── config/        # GoRouter + app routes
│   ├── services/      # API + auth handlers
│   └── widgets/       # Reusable widgets (cards, buttons)
├── features/          # Booking, auth, movies, profile, etc.
├── data/              # Data sources, local persistence
├── domain/            # Models, business logic (Clean Arch)
├── utils/             # Helpers, JWT parsing, extensions
└── main.dart          # App entry point

🧩 Follows a domain-driven modular structure — ready for large-scale projects.


## 🔑 Core Widgets
| Widget              | Purpose                               |
| ------------------- | ------------------------------------- |
| `booking_card.dart` | Generic ticket tile                   |
| `otp_input.dart`    | Custom 6-digit OTP input              |
| `tab_selector.dart` | Switch tabs (bookings, notifications) |
| `profile_card.dart` | Profile + booking history summary     |


##🌍 Language Support (i18n)
📁 assets/translations/en.json
📁 assets/translations/hi.json

```json
// en.json
{
  "login": "Login",
  "book_now": "Book Now"
}

// hi.json
{
  "login": "लॉग इन",
  "book_now": "बुक करें"
}

- 🗣️ Language toggle persists using SharedPreferences
- No restart needed — switches in real-time!


## 🧪 Frontend Testing
Uses Flutter test suite + golden test potential.

| Test Type      | Scope                     | Example Files               | Command        |
| -------------- | ------------------------- | --------------------------- | -------------- |
| ✅ Widget Test  | OTP, Login, Profile       | `auth_provider_test.dart`   | `flutter test` |
| 🌍 i18n Toggle | EN ↔ HI switch at runtime | `language_toggle_test.dart` | `flutter test` |

📘 See: TESTING.md for complete strategy.


## 🔗 API Reference
- Connects to a RESTful Node.js + Prisma backend.
- JWT used in headers for protected endpoints.

| Method | Endpoint  | Description           |
| ------ | --------- | --------------------- |
| GET    | /movies   | Fetch all movies      |
| POST   | /bookings | Create ticket booking |
| POST   | /payments | Simulate payment      |
| GET    | /profile  | Fetch user profile    |

📖 More: /backend_nodejs/README.md


## 🔐 Auth Flow (OTP + JWT)
```plaintext

1. Request OTP → /auth/request-otp
2. Verify OTP   → /auth/verify-otp
3. JWT Token stored → SecureStorage
4. Authenticated requests → Bearer token in header

🔐 Stateless, secure, scalable authentication flow.


## 💡 Unique Engineering Decisions
| 💡 Decision                         | ✅ Justification                    |
| ----------------------------------- | ---------------------------------- |
| `Provider` for state mgmt           | Lightweight, ideal for internships |
| `easy_localization` + `.json`       | Simple, extendable i18n            |
| `GoRouter` for navigation           | Clean, declarative routes          |
| Firebase Push Notifications         | Real-time re-engagement            |
| Modular `core/`, `data/`, `domain/` | Inspired by Clean Architecture     |


## 🔮 Future Enhancements
- 💳 Razorpay or Stripe Payment Gateway
- 🧑‍💼 Admin dashboard (for movies/news management)
- 🌗 Dark mode support
- 🔌 Real-time bookings via WebSocket/Firebase
- 📊 Booking analytics page


## 🛠 Developer Notes
- Reusable widgets across modules (cards, inputs, selectors)
- Try-catch + toast feedback for API/UI failures
- Clean separation of business logic and UI
- Persistent session via token & language storage


## 🙌 Contributions
🎯 This app was built as part of an internship and is maintained for learning & demo purposes.

Feel free to fork, raise issues, or contribute PRs!



## 👨‍💻 Author
Vrund Leuva
📧 vrundleuva3@gmail.com
🔗 LinkedIn
🔗 GitHub


## 📜 License
Released under the MIT License — use freely with proper attribution.
- ✅ Secure your .env, API keys, and Firebase credentials before release.

<p align="center"><strong>📱 TicketEase — Flutter with purpose. Real-world ready.</strong></p> ```