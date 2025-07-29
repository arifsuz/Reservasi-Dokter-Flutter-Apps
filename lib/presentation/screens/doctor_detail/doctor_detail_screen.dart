import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/services/firestore_service.dart';
import '../../../core/services/notification_service.dart';
import '../../../data/models/doctor_model.dart';
import '../../widgets/booking_form_dialog.dart';
import '../../widgets/time_slot_chip.dart';

class DoctorDetailScreen extends StatelessWidget {
  final Doctor doctor;
  final FirestoreService firestoreService;
  final NotificationService notificationService;

  const DoctorDetailScreen({
    super.key,
    required this.doctor,
    required this.firestoreService,
    required this.notificationService,
  });

  // Generate time slots for today
  List<DateTime> _generateTimeSlots() {
    List<DateTime> slots = [];
    final now = DateTime.now();
    // Slots start from 9 AM to 4 PM (16:00)
    for (int i = 9; i <= 16; i++) {
      slots.add(DateTime(now.year, now.month, now.day, i, 0, 0));
    }
    return slots;
  }

  void _showBookingDialog(BuildContext context, DateTime time) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return BookingFormDialog(
          doctorId: doctor.id,
          doctorName: doctor.name,
          appointmentTime: time,
          firestoreService: firestoreService,
          notificationService: notificationService,
        );
      },
    );

    if (result == true && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Reservasi Anda telah berhasil dikonfirmasi!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final timeSlots = _generateTimeSlots();

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Dokter', style: AppStyles.buttonText.copyWith(color: AppColors.primary)),
        backgroundColor: AppColors.white,
        iconTheme: const IconThemeData(color: AppColors.primary),
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 45,
                  backgroundImage: NetworkImage(doctor.photoUrl),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(doctor.name, style: AppStyles.heading1),
                      const SizedBox(height: 4),
                      Text(doctor.specialization, style: AppStyles.heading2.copyWith(color: AppColors.primary, fontSize: 18)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text('Tentang Dokter', style: AppStyles.heading2),
            const SizedBox(height: 8),
            Text(doctor.description, style: AppStyles.bodyText, textAlign: TextAlign.justify),
            const SizedBox(height: 24),
            Text('Pilih Jadwal Hari Ini', style: AppStyles.heading2),
            const SizedBox(height: 12),
            StreamBuilder<List<DateTime>>(
              stream: firestoreService.getBookedSlots(doctor.id, DateTime.now()),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final bookedSlots = snapshot.data ?? [];

                return Wrap(
                  spacing: 10.0,
                  runSpacing: 10.0,
                  children: timeSlots.map((slot) {
                    final isBooked =
                        bookedSlots.any((bookedSlot) => bookedSlot.isAtSameMomentAs(slot));
                    final isPast = slot.isBefore(DateTime.now());

                    return TimeSlotChip(
                      time: slot,
                      isBooked: isBooked,
                      isPast: isPast,
                      onSelected: () => _showBookingDialog(context, slot),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}