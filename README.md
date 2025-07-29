# Doctor Consultation App - Flutter and Firebase

A Flutter-based mobile application for booking and managing doctor appointments. This application provides a seamless experience for users to find doctors, view their schedules, and book consultations.

## ✨ Features

- **User Authentication:** Secure sign-up and login functionality.
- **Doctor Directory:** Browse a list of available doctors with their specializations and schedules.
- **Appointment Booking:** Easily book an available time slot with a chosen doctor.
- **Appointment Management:** View and manage your upcoming and past appointments.
- **Real-time Notifications:** Receive reminders for upcoming appointments and other important updates.
- **Clean & Modern UI:** A user-friendly interface built with Flutter.

## 🚀 Getting Started

Follow these instructions to get a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (v3.x or higher)
- [Dart SDK](https://dart.dev/get-dart)
- An IDE such as [Android Studio](https://developer.android.com/studio) or [VS Code](https://code.visualstudio.com/) with the Flutter plugin.

### Installation

1.  **Clone the repository:**
    ```sh
    git clone https://github.com/your-username/aplikasi_konsultasi_dokter.git
    cd aplikasi_konsultasi_dokter
    ```

2.  **Install dependencies:**
    ```sh
    flutter pub get
    ```

### Firebase Setup

This project uses Firebase for backend services like Firestore and Notifications.

1.  Create a new project on the [Firebase Console](https://console.firebase.google.com/).
2.  Follow the instructions to add an Android and/or iOS app to your Firebase project.
3.  **Android:** Download the `google-services.json` file and place it in the `android/app/` directory.
4.  **iOS:** Download the `GoogleService-Info.plist` file and place it in the `ios/Runner/` directory.
5.  The `lib/firebase_options.dart` file is required for Firebase initialization. It should be generated automatically when you configure your app with the FlutterFire CLI. If not, follow the [FlutterFire documentation](https://firebase.flutter.dev/docs/overview#initialization) to generate it.

    **Note:** These configuration files contain sensitive API keys and are included in the `.gitignore` file to prevent them from being checked into version control.

### Running the Application

- **Run the app on a connected device or emulator:**
  ```sh
  flutter run
  ```

## 📂 Project Structure

The project follows a standard Flutter project structure, with the core logic separated into the following directories under `lib/`:

```
lib/
├── core/
│   ├── constants/      # Application constants (colors, strings, etc.)
│   ├── models/         # Data models
│   └── services/       # Services (Firestore, Notifications)
├── data/
│   └── repositories/   # Data repositories
├── presentation/
│   ├── screens/        # UI screens (widgets)
│   ├── widgets/        # Reusable UI components
│   └── view_models/    # State management logic
├── firebase_options.dart # Firebase configuration
└── main.dart           # Main application entry point
```

## 🛠️ Built With

- [Flutter](https://flutter.dev/) - The UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.
- [Firebase](https://firebase.google.com/) - A platform for building web and mobile applications.
  - [Cloud Firestore](https://firebase.google.com/products/firestore) - NoSQL document database.
  - [Firebase Core](https://firebase.google.com/products/cloud-messaging) - For Firebase initialization.
- [flutter_local_notifications](https://pub.dev/packages/flutter_local_notifications) - For displaying local notifications.
- [google_fonts](https://pub.dev/packages/google_fonts) - For using custom fonts from Google Fonts.

## 🤝 Contributing

Contributions are what make the open-source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".

1.  Fork the Project
2.  Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3.  Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4.  Push to the Branch (`git push origin feature/AmazingFeature`)
5.  Open a Pull Request

## 📸 Screenshots
**1. Home Screen (List of Available Doctors)**

<img width="336" height="748" alt="Home Screen (Daftar Dokter Tersedia)" src="https://github.com/user-attachments/assets/3e1df5fc-6e89-46ff-bfa0-ecf247aaa891" />


**2. Doctor Details**

<img width="336" height="748" alt="Detail Dokter" src="https://github.com/user-attachments/assets/b8193bd8-627e-4b0b-9670-16e7982a63d4" />


**3. Personal Data Form for Consultation**

<img width="336" height="748" alt="Form Data Diri Konsultasi" src="https://github.com/user-attachments/assets/d74d3e14-b190-44de-8184-349574dd7dec" />


**4. Personal Consultation Form (filled out)**

<img width="336" height="748" alt="Form Data Diri Konsultasi (disi)" src="https://github.com/user-attachments/assets/e6d79545-53ad-4274-b511-f7515faf4084" />


**5. Consultation Request Submitted Successfully**

<img width="336" height="748" alt="Pengajuan Konsultasi Berhasil" src="https://github.com/user-attachments/assets/1964c3d0-8c57-4709-87eb-a162005e1ecc" />


**6. Notification**

<img width="336" height="748" alt="Notifikasi" src="https://github.com/user-attachments/assets/d6afcfb0-3be8-41bc-8a73-bff97b9f88af" />



## 📧 **Contact Authors**
**Developed by :**
**Muhamad Nur Arif**
**(41523010147)**

### **🔗 Link**
[![portfolio](https://img.shields.io/badge/my_portfolio-000?style=for-the-badge&logo=ko-fi&logoColor=white)](https://ariftsx.vercel.app/)
[![GitHub](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white)](https://github.com/arifsuz)
[![linkedin](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/marif8/)
[![instagram](https://img.shields.io/badge/Instagram-E4405F?style=for-the-badge&logo=instagram&logoColor=white)](https://www.instagram.com/ariftsx/)

