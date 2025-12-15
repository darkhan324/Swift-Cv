# Swift CV - Professional Resume Builder

A complete Flutter application for building professional CVs and resumes with Firebase backend, supporting web, mobile, and desktop platforms.

## ✨ Features

- **🔐 Google Authentication** - Secure sign-in with Google accounts
- **📄 Resume Builder** - Create professional resumes with multiple sections
- **🎨 Clean UI** - Material 3 design with dark/light themes
- **☁️ Cloud Storage** - Firebase Firestore for data, Storage for files
- **🌐 Multi-Platform** - Runs on Android, iOS, Web, and Windows
- **📱 Responsive** - Adaptive design for all screen sizes
- **🔄 Real-time Sync** - Live data synchronization across devices

## 🚀 Quick Start

### Prerequisites
- Flutter SDK (3.10.0 or higher)
- Firebase account
- Android Studio / Xcode (for mobile development)

### 1. Clone & Setup
```bash
git clone <repository-url>
cd swift_cv
flutter pub get
```

### 2. Firebase Setup
Follow the detailed guide in [`firebase_setup.md`](firebase_setup.md)

**Quick version:**
1. Create Firebase project at https://console.firebase.google.com/
2. Enable Authentication (Google Sign-In)
3. Enable Firestore Database
4. Add Flutter app and download config files
5. Replace placeholder configs in the project

### 3. Run the App
```bash
# For Android
flutter run -d android

# For iOS
flutter run -d ios

# For Web
flutter run -d chrome

# For Windows (if Flutter SDK supports it)
flutter run -d windows
```

## 📁 Project Structure

```
lib/
├── core/                    # App constants and utilities
├── domain/                  # Business logic layer
│   ├── entities/           # Domain models
│   ├── repositories/       # Abstract data interfaces
│   └── usecases/          # Application use cases
├── data/                   # Data layer
│   ├── models/            # Data transfer objects
│   ├── repositories/      # Data implementations
│   └── services/          # External service integrations
├── presentation/          # UI layer
│   ├── providers/         # State management (Riverpod)
│   ├── screens/           # App screens/pages
│   └── widgets/           # Reusable UI components
└── main.dart              # App entry point

android/                    # Android platform code
ios/                       # iOS platform code
web/                       # Web platform code
firebase_setup.md          # Firebase configuration guide
```

## 🛠️ Tech Stack

- **Framework:** Flutter
- **Language:** Dart
- **State Management:** Riverpod
- **Backend:** Firebase (Auth, Firestore, Storage)
- **Architecture:** Clean Architecture
- **UI:** Material 3 Design
- **Platforms:** Android, iOS, Web, Windows

## 🔧 Configuration Files

- `pubspec.yaml` - Flutter dependencies and app config
- `lib/firebase_options.dart` - Firebase platform configurations
- `android/app/google-services.json` - Android Firebase config
- `ios/Runner/GoogleService-Info.plist` - iOS Firebase config
- `web/index.html` - Web app HTML template
- `web/manifest.json` - PWA manifest
- `firestore.rules` - Firestore security rules
- `storage.rules` - Firebase Storage security rules

## 📱 App Features

### Authentication
- Google Sign-In integration
- Persistent login sessions
- User profile management

### Resume Management
- Create, edit, duplicate, delete resumes
- Multiple sections: Personal Info, Experience, Education, Skills, Projects, Certifications
- Custom sections support
- Real-time autosave

### User Interface
- Material 3 design system
- Dark and light themes
- Responsive layout
- Smooth animations
- Loading states and error handling

### Data Storage
- Firebase Firestore for structured data
- Firebase Storage for files/images
- Offline data caching
- Real-time synchronization

## 🚀 Deployment

### Web Deployment
```bash
flutter build web
firebase deploy --only hosting
```

### Mobile Deployment
- **Android:** Follow Google Play Store guidelines
- **iOS:** Follow App Store guidelines

## 🧪 Testing

```bash
# Run tests
flutter test

# Run integration tests
flutter drive --target=test_driver/app.dart
```

## 📝 Development Notes

- Uses Clean Architecture for maintainability
- Riverpod for predictable state management
- Comprehensive error handling
- Modular code structure
- Well-documented code with comments

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🆘 Support

- Check `firebase_setup.md` for Firebase configuration issues
- Ensure Flutter SDK is properly installed
- Verify Firebase project settings match the config files

---

Built with ❤️ using Flutter and Firebase