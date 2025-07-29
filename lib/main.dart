import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // File ini di-generate oleh FlutterFire CLI
import 'core/constants/app_colors.dart';
import 'core/services/firestore_service.dart';
import 'core/services/notification_service.dart';
import 'presentation/screens/home/home_screen.dart';

void main() async {
  // Pastikan binding Flutter siap
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Inisialisasi service
  final NotificationService notificationService = NotificationService();
  await notificationService.init();

  final FirestoreService firestoreService = FirestoreService();

  runApp(MyApp(
    firestoreService: firestoreService,
    notificationService: notificationService,
  ));
}

class MyApp extends StatelessWidget {
  final FirestoreService firestoreService;
  final NotificationService notificationService;

  const MyApp({
    super.key,
    required this.firestoreService,
    required this.notificationService,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doctor Reservation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        useMaterial3: true,
      ),
      home: HomeScreen(
        firestoreService: firestoreService,
        notificationService: notificationService,
      ),
    );
  }
}