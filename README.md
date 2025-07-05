# 🎟️ TicketEase – Full‑Stack Multilingual Booking Platform  

> Comprehensive internship submission showcasing scalable mobile and server‑side design.  
> Flutter frontend + Node.js/Express server + PostgreSQL via Prisma ORM.  

---

## 📘 Table of Contents  
1. [🎯 Executive Summary](#executive-summary)  
2. [🚀 Features](#features)  
3. [🧱 Architecture & Tech Stack](#architecture---tech-stack)  
4. [👨‍💼 Internship Journey & Design Rationale](#internship-journey--design-rationale)  
5. [🧠 Why TicketEase?](#-why-ticketease)
6. [📦 Project Structure](#project-structure)  
7. [🔧 Setup & Running](#setup--running)  
8. [📂 Deep Dive Docs](#deep-dive-docs)  
9. [📞 Contact & License](#contact--license)  

---

## 🎯 Executive Summary  
TicketEase is an internship-built full‑stack platform enabling users to book movies, parking, attractions, and entry tickets. Featuring OTP authentication, seamless language switching (English/Hindi), real‑world booking flows, notifications, and a simulated payment system. Built with production‑grade architecture in mind.

---

## 🚀 Features  
- **🔐 Authentication**: OTP‑based login/signup backed by JWT.  
- **🎟️ Booking System**: Multi-category bookings—movies (with visitor add‑ons), attractions, parking, entry.  
- **🧾 Payments**: Simulated payment flow with success confirmation.  
- **👤 Profile**: View & update information; booking history retrieval.  
- **🔔 Notifications**: Fetch, mark‑read, and count unread alerts.  
- **🌐 Localization**: Runtime English↔Hindi via easy_localization.  
- **📲 Push Notifications**: Firebase-powered.  
- **📊 Dashboard**: Top‑5 items view with detailed lists.

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

## 🧠 Why TicketEase?

TicketEase is not just a demo app — it's a **modular, layered, and scalable** full-stack mobile booking platform that mimics the complexity of real-world production apps.

- Built during internship with a focus on **quality**, **architecture**, and **user experience**
- Uses **clean architecture**, **state management**, and **i18n** principles

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

---

## 🔗 Explore

- 📱 **Frontend Details:** [`frontend_flutter/README.md`](./frontend_flutter/README.md)
- ⚙️ **Backend Details:** [`backend_nodejs/README.md`](./backend_nodejs/README.md)
- 📮 **Postman Collection:** `TicketEase.postman_collection.json`

---

## 👨‍💻 Developed By

Your Name  
📧 your.email@example.com  
🔗 [LinkedIn](https://linkedin.com/in/your-profile)  
🔗 [GitHub](https://github.com/your-username)

---

## 📜 License

MIT License – Free to use with attribution 🙏