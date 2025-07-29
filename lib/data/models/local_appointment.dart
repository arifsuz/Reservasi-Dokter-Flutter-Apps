import 'package:hive/hive.dart';

part 'local_appointment.g.dart'; // File ini akan di-generate

@HiveType(typeId: 0)
class LocalAppointment extends HiveObject {
  @HiveField(0)
  late String doctorName;

  @HiveField(1)
  late String specialization;

  @HiveField(2)
  late DateTime appointmentTime;

  LocalAppointment({
    required this.doctorName,
    required this.specialization,
    required this.appointmentTime,
  });
}