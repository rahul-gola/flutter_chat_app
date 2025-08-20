# Flutter Chat App

A full-featured, modern chat application built with Flutter and Firebase, supporting real-time
messaging between authenticated users. Includes robust architectural design using the BLoC pattern,
dependency injection, and clean code practices for maintainability and scalability.

---

## Features

- **Firebase Authentication:** Secure login and registration via email and password
- **Real-time Messaging:** Send and receive messages instantly with Firestore
- **User List:** Displays all registered users to start a chat
- **Clean Architecture:** Data, Domain, and Presentation (lib) layers
- **State Management:** BLoC and flutter_bloc for decoupled state
- **Dependency Injection:** get_it and injectable
- **Theming:** Material3 with custom colors and Google Fonts
- **Splash & Login Screens:** Beautiful, animated splash and authentication flows
- **Custom Widgets:** For buttons and UI consistency
- **Responsive Layout:** Uses flutter_screenutil for scalable UI
- **Asset Management:** Uses multiple bundled icons and images

---

## Project Structure

- `lib/` — Presentation layer (UI, screens, widgets, DI setup)
- `domain/` — Domain logic, repositories, and use cases
- `data/` — Data sources and service implementations
- `assets/` — App icons, images, and UI graphics
- `test/` — Widget and integration tests

---

## Getting Started

### Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install) (>=3.9.0)
- [Dart SDK](https://dart.dev/get-dart)
- Firebase project (create via [console](https://console.firebase.google.com/))

### Setup Instructions

1. **Clone the repository:**
   ```bash
   git clone <this-repository-url>
   cd flutter_chat_app
   ```
2. **Install packages:**
   ```bash
   flutter pub get
   ```
3. **Configure Firebase:**
    - Create a Firebase project
    - Add Android/iOS app to Firebase
    - Download `google-services.json` (Android) and/or `GoogleService-Info.plist` (iOS)
    - Place those files in respective platform directories
    - Enable Email/Password authentication in Firebase console
4. **Run code generation:**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```
5. **Run the app:**
   ```bash
   flutter run
   ```

---

## Dependencies

- flutter_bloc
- get_it
- injectable (+ injectable_generator)
- firebase_core
- firebase_auth
- cloud_firestore
- flutter_screenutil
- google_fonts
- cupertino_icons
- animated_splash_screen
- intl

---

## Architecture

This project uses a layered, testable architecture:

- **Presentation Layer:** UI, widgets, navigation, theming, and top-level app logic. Managed with
  BLoC for state using custom base widgets for lifecycle and dependency management.
- **Domain Layer:** Business logic, use cases, and repository interfaces.
- **Data Layer:** Firebase/Firestore implementation of repositories, mappers, and API clients.

DI is handled with [`get_it`](https://pub.dev/packages/get_it) and auto-registered via [
`injectable`](https://pub.dev/packages/injectable).

---

## Contribution Guidelines

- Fork this repo and create a feature branch
- Run `flutter analyze` to check code style
- Add tests for new features
- Open a pull request and describe your changes

---
