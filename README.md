# 🎟️ TicketEase – Full‑Stack Multilingual Booking Platform  

> Comprehensive internship submission showcasing scalable mobile and server‑side design.  
> Flutter frontend + Node.js/Express server + PostgreSQL via Prisma ORM.  

![TicketEase Logo](https://source.unsplash.com/random/500x150/?ticket,logo)

---

## 📘 Table of Contents  

1. [🎯 Executive Summary](#executive-summary)  
2. [🚀 Key Features](#key-features)  
3. [🧱 Architecture & Tech Stack](#architecture---tech-stack) 
4. [📦 Project Structure](#project-structure) 
5. [🧪 Quality Assurance & Testing Report](#quality-assurance--testing-report) 
6. [🔗 Explore](#explore) 
7. [🧠 Why TicketEase?](#-why-ticketease)
8. [👨‍💼 Internship Journey & Design Rationale](#internship-journey--design-rationale)  
9. [🔧 Setup & Running](#setup--running)  
10. [👨‍💻 Contact](#contact)
11. [📜 License & Security Notice](#license-&--security-notice)  

---

## 🎯 Executive Summary  
TicketEase is an internship-built full‑stack platform enabling users to book movies, parking, attractions, and entry tickets. Featuring OTP authentication, seamless language switching (English/Hindi), real‑world booking flows, notifications, and a simulated payment system. Built with production‑grade architecture in mind.

---

## 🚀 Key Features  

| Feature | Description |
|--------|-------------|
| 🔐 OTP + JWT Auth | Stateless, secure login |
| 🌐 i18n | English 🇬🇧 & Hindi 🇮🇳 support |
| 🎫 Bookings | Movies, Attractions, Parking, Entry |
| 📲 Push Notifications | Firebase-based alerts |
| 🔔 Notifications | List, count, mark read/all-read |
| 👤 Profile | View & edit + Booking history |
| 💳 Payment Flow | Simulated checkout with success |
| 📊 Dashboard | Top-5 cards & insights |

---

## 🧱 Architecture & Tech Stack  

### 🧭 Why These Choices  
- **Flutter + Dart**: Cross-platform UI with clean architecture, null safety, and ready for expansion.  
- **GoRouter + Provider**: For declarative navigation and responsive state management.  
- **Node.js + Express**: Fast, modular REST API suited for iterative backend development.  
- **Prisma + PostgreSQL**: Schema-driven, type-safe ORM maintaining relational integrity.  
- **OTP + JWT**: Secure stateless authentication, ideal for mobile context.  
- **SharedPreferences & SecureStorage**: Persistent user data and tokens.  
- **Firebase Messaging**: Reliable push notification backend.  


### 🔄 Rejected Alternatives  
- **Bloc instead of Provider**: Chosen Provider for its simplicity and quicker implementation during internship.  
- **TypeORM instead of Prisma**: Prisma offers better type safety and developer DX.  
- **Firebase Auth**: Instead, OTP + JWT allowed full control of authentication flows.

---

## 🧪 Quality Assurance & Testing Report

| Area                            | Status | Notes                                   |
| ------------------------------- | ------ | --------------------------------------- |
| API Testing (Postman)           | ✅      | Done + documented                       |
| Backend Unit Testing (Jest) | ✅      | Added using `jest` and `supertest`      |
| UI Testing (flutter\_test)      | ✅      | Login, language switch                  |
| Localization Testing            | ✅      | Dropdown + EN/HI switch                 |
| Edge Case & Error Testing       | ✅      | Invalid inputs, OTP, empty booking      |
| Test Documentation              | ✅      | README with all tables                  |

See [TESTING.md](./TESTING.md) for detailed testing strategy and QA report.

---

## 🔗 Explore

- 📱 **Frontend Details:** [`frontend_flutter/README.md`](./frontend_flutter/README.md)
- ⚙️ **Backend Details:** [`backend_nodejs/README.md`](./backend_nodejs/README.md)
- 🧪 **Testing Details**[`TESTING.md`](./TESTING.md)

---

## 🧠 Why TicketEase?

TicketEase is not just a demo app — it's a **modular, layered, and scalable** full-stack mobile booking platform that mimics the complexity of real-world production apps.

- Built during internship with a focus on **quality**, **architecture**, and **user experience**
- Uses **clean architecture**, **state management**, and **i18n** principles

---

## 👨‍💼 Internship Journey & Design Rationale  
- **Problem**: Build a real‑world booking app end‑to‑end under real constraints.  
- **Approach**:  
  1. Rapidtech MVP with OTP/JWT flows.  
  2. Modular Flutter architecture: `core`, `features`, `data`, `domain`.  
  3. Backend built feature-by-feature: controllers, routes, middleware.  
  4. Iterative localization support with easy_localization + JSON.  
  5. Added push notifications mid-way via Firebase.  
  6. Emphasis on reusable widgets and consistent UI patterns.

---

## 🧭 Project Structure

TicketEase/
├── frontend_flutter/ # Flutter mobile application
│ └── README.md # 📱 Flutter app documentation
├── backend_nodejs/ # Node.js RESTful API backend
│ └── README.md # ⚙️ Backend API documentation
└── README.md # 📦 Main project overview (this file)

---

## 🧾 API + Architecture

- RESTful API with secure **JWT Auth**
- **Prisma** ORM with type-safe PostgreSQL schema
- Modular folder structure in backend for scalability
- Flutter frontend follows **Clean Architecture** with `data`, `domain`, and `features` layers

## 👨‍💻 Contact

Developed during internship at **Silver Touch Technologies**

**Your Name**  
📧 your.email@example.com  
🔗 [GitHub](https://github.com/your-username)  
🔗 [LinkedIn](https://linkedin.com/in/your-profile)

---

## 📜 License & Security Notice

MIT License – Free to use with attribution 🙏

### Notice
- Never commit real `.env` files to GitHub.
- JWT secrets and database URLs must be stored in environment variables.
- Inputs (like OTP, email, count) are validated at both client & server level.
- All user-sensitive data is stored securely using JWT and encrypted storage.
