import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/services/firestore_service.dart';
import '../../../core/services/notification_service.dart';
import '../../../data/models/doctor_model.dart';
import '../../widgets/doctor_card.dart';
import '../doctor_detail/doctor_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  final FirestoreService firestoreService;
  final NotificationService notificationService;

  const HomeScreen({
    super.key,
    required this.firestoreService,
    required this.notificationService,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Doctor>> _doctorsFuture;

  @override
  void initState() {
    super.initState();
    _doctorsFuture = widget.firestoreService.getDoctors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text('Pilih Dokter', style: AppStyles.buttonText),
        backgroundColor: AppColors.primary,
        elevation: 0,
      ),
      body: FutureBuilder<List<Doctor>>(
        future: _doctorsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Terjadi kesalahan: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Tidak ada dokter yang tersedia.'));
          }

          final doctors = snapshot.data!;
          return RefreshIndicator(
            onRefresh: () async {
              setState(() {
                _doctorsFuture = widget.firestoreService.getDoctors();
              });
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: doctors.length,
              itemBuilder: (context, index) {
                final doctor = doctors[index];
                return DoctorCard(
                  doctor: doctor,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DoctorDetailScreen(
                          doctor: doctor,
                          firestoreService: widget.firestoreService,
                          notificationService: widget.notificationService,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}