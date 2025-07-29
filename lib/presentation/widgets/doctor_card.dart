import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../data/models/doctor_model.dart';

class DoctorCard extends StatelessWidget {
  final Doctor doctor;
  final VoidCallback onTap;

  const DoctorCard({
    super.key,
    required this.doctor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 3,
      shadowColor: AppColors.primary.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 35,
                backgroundColor: AppColors.accent,
                backgroundImage: doctor.photoUrl.isNotEmpty
                    ? NetworkImage(doctor.photoUrl)
                    : null,
                child: doctor.photoUrl.isEmpty
                    ? const Icon(Icons.person, size: 40, color: AppColors.primary)
                    : null,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(doctor.name, style: AppStyles.heading2.copyWith(fontSize: 18)),
                    const SizedBox(height: 4),
                    Text(
                      doctor.specialization,
                      style: AppStyles.bodyText.copyWith(
                          color: AppColors.primary, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: AppColors.primary, size: 28),
            ],
          ),
        ),
      ),
    );
  }
}