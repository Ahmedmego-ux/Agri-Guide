# 🌱 Agri Guide — Flutter Agricultural Marketplace App

A production-ready Flutter application that connects farmers and agricultural enthusiasts with essential farming products. Built with Clean Architecture, Bloc/Cubit state management, and REST API integration using Dio.

> ⚡ Built to demonstrate real-world Flutter development practices: scalable structure, clean separation of concerns, and robust API handling.

---

## 📱 Screenshots

| Home Screen | Market | Product Details | Product Details 2 |
|---|---|---|---|
| ![home](https://raw.githubusercontent.com/Ahmedmego-ux/Agri-Guide/main/assets/screenshots/home.png) | ![market](https://raw.githubusercontent.com/Ahmedmego-ux/Agri-Guide/main/assets/screenshots/market.png) | ![details](https://raw.githubusercontent.com/Ahmedmego-ux/Agri-Guide/main/assets/screenshots/details.png) | ![details2](https://raw.githubusercontent.com/Ahmedmego-ux/Agri-Guide/main/assets/screenshots/details2.png) |

---

## ✅ Key Features

- 🛒 **Product Marketplace** — Browse fertilizers, tools, seeds with full detail views
- 🔍 **Smart Search & Filter** — Search by name or category in real time
- 🌐 **REST API Integration** — Live product data via Dio with full error handling
- 🏗️ **Clean Architecture** — Feature-first structure, fully scalable
- ⚙️ **Bloc / Cubit** — Predictable, testable state management throughout

---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| Framework | Flutter (Dart) |
| State Management | Bloc / Cubit |
| Networking | Dio |
| Architecture | Clean Architecture (Feature-first) |
| Error Handling | Custom API error handling layer |

---

## 🏗️ Project Structure

```
lib/
├── core/
│   ├── network/        # Dio client, API service, error handling
│   └── utils/          # Shared helpers & utilities
│
└── feature/
    └── market/
        ├── data/           # Models & repositories
        └── presentation/
            ├── manager/    # Cubit + States
            ├── views/      # Screens
            └── widgets/    # Reusable UI components
```

---

## 🚀 Getting Started

```bash
git clone https://github.com/Ahmedmego-ux/Agri-Guide.git
cd Agri-Guide
flutter pub get
flutter run
```

**Requirements:** Flutter SDK 3.x+, Android Studio or VS Code

---

## 🔌 API

Currently consuming: `https://gogarden.co.in/products.json`

---

## 📌 Roadmap

- [ ] Full pagination support
- [ ] Favorites / Wishlist
- [ ] Cart & Checkout flow
- [ ] Firebase Authentication
- [ ] Supabase backend integration
- [ ] Arabic / English localization

---

## 👨‍💻 Author

**Ahmed Magdy** — Flutter Developer

---

⭐ If you found this useful, please give it a star on GitHub!