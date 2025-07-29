import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../core/services/firestore_service.dart';
import '../../core/services/notification_service.dart';

class BookingFormDialog extends StatefulWidget {
  final String doctorId;
  final String doctorName;
  final DateTime appointmentTime;
  final FirestoreService firestoreService;
  final NotificationService notificationService;

  const BookingFormDialog({
    super.key,
    required this.doctorId,
    required this.doctorName,
    required this.appointmentTime,
    required this.firestoreService,
    required this.notificationService,
  });

  @override
  State<BookingFormDialog> createState() => _BookingFormDialogState();
}

class _BookingFormDialogState extends State<BookingFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  String? _gender;
  bool _isLoading = false;

  Future<void> _submitBooking() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      bool success = await widget.firestoreService.createBooking(
        doctorId: widget.doctorId,
        doctorName: widget.doctorName,
        appointmentTime: widget.appointmentTime,
        patientName: _nameController.text,
        patientAge: int.parse(_ageController.text),
        patientGender: _gender!,
      );

      if (mounted) {
        setState(() => _isLoading = false);
        if (success) {
          // Schedule notification
          final reminderTime = widget.appointmentTime.subtract(const Duration(hours: 1));
          if (reminderTime.isAfter(DateTime.now())) {
            await widget.notificationService.scheduleNotification(
              id: widget.appointmentTime.hashCode,
              title: 'Pengingat Janji Temu',
              body:
                  'Anda punya jadwal dengan ${widget.doctorName} jam ${DateFormat('HH:mm').format(widget.appointmentTime)}.',
              scheduledTime: reminderTime,
            );
          }

          Navigator.of(context).pop(true); // Return true on success
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Gagal membuat reservasi. Coba lagi.')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Text('Konfirmasi Data Diri', style: AppStyles.heading2),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Jadwal: ${DateFormat('d MMMM y, HH:mm').format(widget.appointmentTime)}',
                style: AppStyles.bodyText.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nama Lengkap', border: OutlineInputBorder()),
                validator: (value) =>
                    value!.trim().isEmpty ? 'Nama tidak boleh kosong' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _ageController,
                decoration: const InputDecoration(labelText: 'Usia', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Usia tidak boleh kosong';
                  if (int.tryParse(value) == null) return 'Masukkan angka yang valid';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _gender,
                hint: const Text('Pilih Jenis Kelamin'),
                decoration: const InputDecoration(border: OutlineInputBorder()),
                items: ['Pria', 'Wanita']
                    .map((label) => DropdownMenuItem(value: label, child: Text(label)))
                    .toList(),
                onChanged: (value) => setState(() => _gender = value),
                validator: (value) => value == null ? 'Pilih jenis kelamin' : null,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Batal')),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.white,
          ),
          onPressed: _isLoading ? null : _submitBooking,
          child: _isLoading
              ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
              : const Text('Konfirmasi'),
        ),
      ],
    );
  }
}