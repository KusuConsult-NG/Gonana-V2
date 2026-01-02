# Gonana Enhanced

Gonana Enhanced is a modern, feature-rich mobile application built with Flutter, designed to revolutionize the agriculture marketplace. It features a clean architecture, robust state management with Bloc, and a premium "Deep Green" aesthetic.

## Features

*   **Authentication**: Secure Sign In, Sign Up, and Forgot Password flows.
*   **Biometric Login**: Fast and secure access using Fingerprint or Face ID.
*   **Marketplace**: Browse hot deals, view product details, and manage orders.
*   **Wallet**: Track balances (USDT, USDC), view transaction history, and switch networks.
*   **Feeds**: Stay updated with the latest stories and posts from the community.
*   **Chat**: Real-time messaging between users (Buyers & Farmers).
*   **Settings**: Manage profile, app preferences, and view legal info.

## Tech Stack

*   **Framework**: Flutter (Dart)
*   **State Management**: `flutter_bloc`
*   **Navigation**: `go_router`
*   **DI**: `get_it`, `injectable`
*   **Network**: `dio`
*   **Local Auth**: `local_auth`
*   **Code Generation**: `freezed`, `json_serializable`

## Getting Started

1.  **Prerequisites**: Ensure you have Flutter installed and configured.
2.  **Dependencies**: Run `flutter pub get` to install packages.
3.  **Code Gen**: Run `dart run build_runner build --delete-conflicting-outputs` to generate code.
4.  **Run**: Execute `flutter run` to start the app on your emulator or device.

## Project Structure

*   `lib/core`: Shared code (theme, utils, widgets).
*   `lib/features`: Feature-based modules (Auth, Market, Wallet, Feeds, Settings).
*   `lib/config`: Application configuration (Router, Injection).

## Architecture

This project follows a **Feature-First Clean Architecture**:
*   **Domain**: Entities, Repository Interfaces (Pure Dart, no Flutter dependencies).
*   **Data**: Repository Implementations, DTOs, Data Sources.
*   **Presentation**: BLoCs, Pages, Widgets.

## Contact

For support or inquiries, please contact the Gonana team.
