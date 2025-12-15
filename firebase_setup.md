# Firebase Setup Guide for Swift CV

## 🚀 Quick Setup

### 1. Create Firebase Project
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Create a project" or "Add project"
3. Name it "swift-cv-app" (or your preferred name)
4. Enable Google Analytics (recommended)
5. Choose your Google Analytics account
6. Click "Create project"

### 2. Enable Authentication
1. In your Firebase project, go to "Authentication"
2. Click "Get started"
3. Go to "Sign-in method" tab
4. Enable "Google" sign-in method
5. Add your project support email
6. Save changes

### 3. Set up Firestore Database
1. Go to "Firestore Database"
2. Click "Create database"
3. Choose "Start in test mode" (for development)
4. Select a location (choose the closest to your users)
5. Click "Done"

### 4. Set up Firebase Storage (Optional - for file uploads)
1. Go to "Storage"
2. Click "Get started"
3. Choose "Start in test mode"
4. Click "Done"

### 5. Add Flutter App to Firebase
1. In Firebase console, click the gear icon → "Project settings"
2. Scroll down to "Your apps" section
3. Click "Add app" → Flutter icon

### 6. Configure Platforms

#### For Android:
1. In Firebase console, click "Add app" → Android
2. Package name: `com.example.swift_cv`
3. App nickname: "Swift CV Android"
4. Click "Register app"
5. Download `google-services.json`
6. Place it in `android/app/google-services.json` (replace existing file)

#### For iOS:
1. In Firebase console, click "Add app" → iOS
2. Bundle ID: `com.example.swiftCv`
3. App nickname: "Swift CV iOS"
4. Click "Register app"
5. Download `GoogleService-Info.plist`
6. Place it in `ios/Runner/GoogleService-Info.plist` (replace existing file)

#### For Web:
1. In Firebase console, click "Add app" → Web
2. App nickname: "Swift CV Web"
3. Also set up Firebase Hosting (optional): Check "Also set up Firebase Hosting"
4. Click "Register app"
5. Copy the config values and update `lib/firebase_options.dart`

### 7. Install FlutterFire CLI (if not installed)
```bash
dart pub global activate flutterfire_cli
```

### 8. Fix PATH Environment Variable (Windows)
If you get "flutterfire is not recognized" error:

**Option A: PowerShell script (Recommended)**
```powershell
# Run as Administrator
.\fix_path.ps1
```

**Option B: Batch script**
```cmd
# Run as Administrator
fix_path.bat
```

**Option C: Manual PATH setup**
1. Press `Win + R`, type `sysdm.cpl`, press Enter
2. Go to "Advanced" tab → "Environment Variables"
3. Under "User variables", find and edit "Path"
4. Add: `C:\Users\%USERNAME%\AppData\Local\Pub\Cache\bin`
5. Click OK and restart your terminal

### 9. Configure FlutterFire
```bash
flutterfire configure --project=swift-cv-app
```
This will automatically update your Firebase configuration files.

## 🔧 Manual Configuration (Alternative)

If you prefer manual setup, update these files with your actual Firebase config:

### `lib/firebase_options.dart`
Replace the placeholder values with your actual Firebase config from the console.

### `android/app/google-services.json`
Replace with the downloaded file from Firebase console.

### `ios/Runner/GoogleService-Info.plist`
Replace with the downloaded file from Firebase console.

## 🛡️ Security Rules

### Firestore Rules (Update in Firebase Console → Firestore → Rules)
```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users can read/write their own data
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }

    // Users can read/write their own resumes
    match /resumes/{resumeId} {
      allow read, write: if request.auth != null &&
        resource.data.userId == request.auth.uid;
      allow create: if request.auth != null &&
        request.auth.uid == request.resource.data.userId;
    }

    // Templates are readable by all authenticated users
    match /templates/{templateId} {
      allow read: if request.auth != null;
    }
  }
}
```

### Storage Rules (Update in Firebase Console → Storage → Rules)
```
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    // Users can upload/read their own files
    match /users/{userId}/{allPaths=**} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }

    // Resume exports are readable by the owner
    match /resumes/{userId}/{allPaths=**} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
  }
}
```

## 🧪 Testing the Setup

1. Run the app:
```bash
flutter run
```

2. Try Google Sign-In
3. Create a test resume
4. Check Firebase console to see data being stored

## 🚀 Deployment

### Web Deployment:
```bash
flutter build web
firebase deploy --only hosting
```

### Mobile App Store Deployment:
- Follow standard Flutter deployment guides for Android/iOS

## 📝 Notes

- The current config uses dummy values for development
- Replace all placeholder values with real Firebase config
- For production, update Firestore/Storage rules to be more restrictive
- Consider enabling Firebase Crashlytics for error reporting

## 🆘 Troubleshooting

- **Sign-in not working**: Check Google Sign-In is enabled in Firebase console
- **Data not saving**: Check Firestore rules and network connectivity
- **Build errors**: Ensure all config files are properly placed and formatted

Happy coding! 🎉