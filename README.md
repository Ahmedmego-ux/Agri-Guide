# 🌱 Agri Guide — Flutter Agricultural Marketplace App

A production-ready Flutter application that connects farmers and agricultural enthusiasts with essential farming products. Built with Clean Architecture, Bloc/Cubit state management, REST API integration using Dio, and an AI-powered chatbot.

> ⚡ Built to demonstrate real-world Flutter development practices: scalable structure, clean separation of concerns, and robust API handling.

---

## 📱 Screenshots

| Home | Market | Product Details | Product Details 2 |
|---|---|---|---|
| ![home](https://raw.githubusercontent.com/Ahmedmego-ux/Agri-Guide/main/assets/screenshots/home.png) | ![market](https://raw.githubusercontent.com/Ahmedmego-ux/Agri-Guide/main/assets/screenshots/market.png) | ![details](https://raw.githubusercontent.com/Ahmedmego-ux/Agri-Guide/main/assets/screenshots/details.png) | ![details2](https://raw.githubusercontent.com/Ahmedmego-ux/Agri-Guide/main/assets/screenshots/details2.png) |

| Login | Onboarding 1 | Onboarding 2 | Profile |
|---|---|---|---|
| ![login](https://raw.githubusercontent.com/Ahmedmego-ux/Agri-Guide/main/assets/screenshots/login.png) | ![onboard1](https://raw.githubusercontent.com/Ahmedmego-ux/Agri-Guide/main/assets/screenshots/onboard1.png) | ![onboard2](https://raw.githubusercontent.com/Ahmedmego-ux/Agri-Guide/main/assets/screenshots/onboard2.png) | ![profile](https://raw.githubusercontent.com/Ahmedmego-ux/Agri-Guide/main/assets/screenshots/profile.png) |

| Chatbot | Chatbot 2 | Signup | |
|---|---|---|---|
| ![chatbot](https://raw.githubusercontent.com/Ahmedmego-ux/Agri-Guide/main/assets/screenshots/chatbot.png) | ![chatbot2](https://raw.githubusercontent.com/Ahmedmego-ux/Agri-Guide/main/assets/screenshots/chatbot2.png) | ![signup](https://raw.githubusercontent.com/Ahmedmego-ux/Agri-Guide/main/assets/screenshots/singup.png) | |

---

## ✅ Key Features

- 🤖 **AI Chatbot** — Integrated smart chatbot powered by Groq API
- 🛒 **Product Marketplace** — Browse fertilizers, tools, and seeds with full detail views
- 🔍 **Smart Search & Filter** — Search by name or category in real time
- 🌐 **REST API Integration** — Live product data via Dio with full error handling
- 🔐 **Authentication** — Login, Signup, Reset Password via Supabase
- 🌱 **Crop Recommendation** — AI-based crop recommendation feature (coming soon)
- 🏗️ **Clean Architecture** — Feature-first structure, fully scalable
- ⚙️ **Bloc / Cubit** — Predictable, testable state management throughout

---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| Framework | Flutter (Dart) |
| State Management | Bloc / Cubit |
| Networking | Dio |
| Authentication | Supabase |
| AI Chatbot | Groq API |
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
    ├── auth/
    │   ├── data/
    │   ├── domain/
    │   └── presentation/
    ├── onboard/
    │   ├── view/
    │   └── widgets/
    ├── home/
    │   ├── data/
    │   ├── domain/
    │   └── presentation/
    ├── market/
    │   ├── data/
    │   ├── domain/
    │   └── presentation/
    ├── crop_recom/
    │   ├── data/
    │   ├── domain/
    │   └── presentation/
    ├── chat_bot/
    │   ├── data/
    │   ├── domain/
    │   └── presentation/
    ├── profile/
    │   ├── data/
    │   ├── domain/
    │   └── presentation/
    └── settings/
        ├── view/
        └── widgets/
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

## 🔌 APIs Used

- Market Data: `https://gogarden.co.in/products.json`
- AI Chatbot: Groq API
- Backend & Auth: Supabase

---

## 📌 Roadmap

- [ ] Crop recommendation AI integration
- [ ] Full pagination support
- [ ] Favorites / Wishlist
- [ ] Cart & Checkout flow
- [ ] Arabic / English localization
- [ ] Offline support

---

## 👨‍💻 Author

**Ahmed Magdy** — Flutter Developer

---

⭐ If you found this useful, please give it a star on GitHub!