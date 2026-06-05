# Daily Notes & Tasks App

A simple and user-friendly Daily Notes & Tasks mobile application built with Flutter.

## Screenshots
Home Screen | Add Task | Dark Mode
---|---|---
Task list with progress | Add/Edit tasks | Toggle dark mode

## Features

### Core Features
- Splash Screen with animation
- Home Screen with task progress bar
- Add Task Screen
- Add, Edit, Delete tasks
- Mark tasks as completed
- Local storage with Hive (tasks persist after restart)

### Bonus Features
- Dark Mode toggle
- Task Categories (Personal, Work, Shopping, Health, Other)
- Category filter chips
- Due Date picker
- Smooth animations
- Delete confirmation dialog

## Tech Stack

- **Framework:** Flutter
- **Language:** Dart
- **State Management:** Provider
- **Local Storage:** Hive
- **Platform:** Android

## Project Structure
lib/
├── main.dart
├── models/
│   └── task.dart
├── providers/
│   └── task_provider.dart
├── screens/
│   ├── splash_screen.dart
│   ├── home_screen.dart
│   └── add_task_screen.dart
## Setup Instructions

### Requirements
- Flutter SDK 3.x
- Android Studio
- Android device or emulator (Android 6.0+)

### Steps

1. Clone the repository
git clone https://github.com/rabia-irshad2/daily-notes-tasks.git

2. Go to project folder

cd daily-notes-tasks

3. Install dependencies

flutter pub get

4. Generate Hive adapters
dart run build_runner build --delete-conflicting-outputs

5. Run the app

flutter run

## Build APK
flutter build apk --release

APK location:
build/app/outputs/flutter-apk/app-release.apk

## Packages Used

| Package | Version | Purpose |
|---------|---------|---------|
| provider | ^6.1.5 | State Management |
| hive | ^2.2.3 | Local Database |
| hive_flutter | ^1.1.0 | Hive Flutter support |
| intl | ^0.20.2 | Date Formatting |
| path_provider | ^2.1.5 | File paths |

## Developer

Rabia Irshad  
GitHub: https://github.com/rabia-irshad2

