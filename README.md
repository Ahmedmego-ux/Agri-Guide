# 🌱 Agri Guide — Flutter Agricultural App

A production-ready Flutter application built for farmers and agricultural enthusiasts. Features include AI-powered plant disease detection via image scanning (FastAPI backend), an AI chatbot powered by Groq, crop recommendations, scan history, weather forecasting based on user location, and an agricultural product marketplace with WhatsApp ordering. Supports dark mode and Arabic/English localization. Built with Clean Architecture, Bloc/Cubit state management, Dio for REST API integration, and Supabase for authentication, chat storage (Edge Functions), and scan history.

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

- 🔐 **Authentication** — Login, Signup (with location capture), Reset Password via Supabase
- 🌿 **Plant Disease Detection** — Scan a plant image and get an AI-powered diagnosis via FastAPI backend
- 📋 **Scan History** — View all previous plant scans stored in Supabase
- 🌾 **Crop Recommendation** — AI-based crop recommendations tailored to the user
- 🤖 **AI Chatbot** — Smart agricultural chatbot powered by Groq API, with chat history stored in Supabase via Edge Functions
- 🛒 **Product Marketplace** — Browse fertilizers, tools, and seeds; orders are placed directly via WhatsApp
- 🔍 **Smart Search & Filter** — Search products by name or category in real time
- 🌤️ **Weather** — Live local weather displayed inside the app based on user location (GoGarden API)
- 👤 **Profile** — View and edit profile info including location update
- 🌙 **Dark Mode** — Full dark/light theme support
- 🌐 **Arabic / English** — Full localization support (AR & EN)

---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| Framework | Flutter (Dart) |
| State Management | Bloc / Cubit |
| Networking | Dio |
| Authentication | Supabase |
| Database & Storage | Supabase (scan history, chat history) |
| Edge Functions | Supabase Edge Functions (chatbot) |
| AI Disease Detection | FastAPI (custom backend) |
| AI Chatbot | Groq API |
| Weather | GoGarden API |
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
    ├── scan/
    │   ├── data/
    │   ├── domain/
    │   └── presentation/
    ├── scan_history/
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
    ├── weather/
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

| API | Usage |
|---|---|
| Supabase | Authentication, scan history, chat storage via Edge Functions |
| FastAPI (custom) | AI-powered plant disease detection |
| Groq API | AI chatbot |
| GoGarden API (`https://gogarden.co.in`) | Weather & product data |

---

## 👨‍💻 Author

**Ahmed Magdy** — Flutter Developer

---

⭐ If you found this useful, please give it a star on GitHub!
