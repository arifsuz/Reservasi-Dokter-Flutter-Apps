import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
import '../../../data/models/local_appointment.dart';

class NotificationListScreen extends StatelessWidget {
  const NotificationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jadwal Janji Temu', style: AppStyles.buttonText),
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ValueListenableBuilder<Box<LocalAppointment>>(
        valueListenable: Hive.box<LocalAppointment>('appointments').listenable(),
        builder: (context, box, _) {
          // Filter hanya janji temu yang akan datang
          var appointments = box.values
              .where((appt) => appt.appointmentTime.isAfter(DateTime.now()))
              .toList();

          // Urutkan berdasarkan yang paling dekat
          appointments.sort((a, b) => a.appointmentTime.compareTo(b.appointmentTime));

          if (appointments.isEmpty) {
            return Center(
              child: Text(
                'Tidak ada jadwal janji temu.',
                style: AppStyles.bodyText,
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: appointments.length,
            itemBuilder: (context, index) {
              final appointment = appointments[index];
              return Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: ListTile(
                  leading: const Icon(Icons.calendar_month, color: AppColors.primary, size: 40),
                  title: Text(appointment.doctorName, style: AppStyles.heading2.copyWith(fontSize: 16)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(appointment.specialization),
                      const SizedBox(height: 4),
                      Text(
                        DateFormat('EEEE, d MMMM y, HH:mm').format(appointment.appointmentTime),
                        style: AppStyles.bodyText.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}