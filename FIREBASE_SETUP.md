# Firebase Setup Guide

This project uses **Firebase** for Authentication, Database (Firestore), and Storage.
You must configure your Firebase project to generate the correct API keys in `lib/firebase_options.dart`.

## Prerequisites

1.  **Firebase Account**: [Sign up here](https://console.firebase.google.com/).
2.  **Node.js**: Required to install Firebase CLI.

## Step 1: Install CLIs

Runs these commands in your terminal:

```bash
# 1. Install Firebase CLI (if not installed)
npm install -g firebase-tools

# 2. Install FlutterFire CLI (if not installed)
dart pub global activate flutterfire_cli
```

## Step 2: Login to Firebase

```bash
firebase login
```
This will open your browser. Log in with your Google account.

## Step 3: Configure Project

Run the following command in the **root** of your project (where `pubspec.yaml` is):

```bash
flutterfire configure
```

1.  Select your **Firebase Project** (or create a new one).
2.  Select the platforms you are building for (Android, iOS, Web, macOS).
3.  The CLI will automatically register your apps and generate the `lib/firebase_options.dart` file.

## Step 4: Verify

Open `lib/firebase_options.dart`. It should now contain real API keys instead of placeholders like `'REPLACE_WITH_YOUR_KEY'`.

## Step 5: Enable Features in Console

Go to the [Firebase Console](https://console.firebase.google.com/):

1.  **Authentication**:
    *   Go to **Build** > **Authentication** > **Get Started**.
    *   Enable **Email/Password** provider.
    *   *(Optional)* Enable Google Sign-In if you plan to add it later.

2.  **Firestore Database**:
    *   Go to **Build** > **Firestore Database** > **Create Database**.
    *   Start in **Test Mode** (for development).
    *   Select a location close to you.

3.  **Storage**:
    *   Go to **Build** > **Storage** > **Get Started**.
    *   Start in **Test Mode**.

## Troubleshooting

*   **"Command not found"**: Ensure your global bin paths are in your system PATH.
    *   FLutterFire: `$HOME/.pub-cache/bin`
*   **"Android build failed"**: Ensure you have the `google-services.json` generated (FlutterFire does this automatically).
