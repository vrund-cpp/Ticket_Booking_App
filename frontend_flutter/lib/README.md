# 🎟️ TicketEase – Mobile Ticket Booking App

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

## 🧠 Why TicketEase?

TicketEase is not just a demo app — it's a **modular, layered, and scalable** full-stack mobile booking platform that mimics the complexity of real-world production apps.

- Built during internship with a focus on **quality**, **architecture**, and **user experience**
- Uses **clean architecture**, **state management**, and **i18n** principles

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
├── features/ # Modular feature folders (booking, movies, payment, profile, notifications etc.)
├── data/ # Network + local storage logic
├── domain/ # Models/entities (clean architecture)
└── main.dart # Entry point