import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/constants/app_colors.dart';

class TimeSlotChip extends StatelessWidget {
  final DateTime time;
  final bool isBooked;
  final bool isPast;
  final VoidCallback onSelected;

  const TimeSlotChip({
    super.key,
    required this.time,
    required this.isBooked,
    required this.isPast,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    bool isEnabled = !isBooked && !isPast;
    return ChoiceChip(
      label: Text(DateFormat('HH:mm').format(time)),
      selected: false, // Purely for tap handling
      labelStyle: TextStyle(
        color: isEnabled ? AppColors.primary : AppColors.white,
        fontWeight: FontWeight.bold,
      ),
      backgroundColor: isEnabled ? AppColors.accent : AppColors.disabled,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: isEnabled ? AppColors.primary : Colors.transparent,
        ),
      ),
      onSelected: isEnabled ? (_) => onSelected() : null,
    );
  }
}