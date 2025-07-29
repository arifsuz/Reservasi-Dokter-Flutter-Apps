// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_appointment.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocalAppointmentAdapter extends TypeAdapter<LocalAppointment> {
  @override
  final int typeId = 0;

  @override
  LocalAppointment read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalAppointment(
      doctorName: fields[0] as String,
      specialization: fields[1] as String,
      appointmentTime: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, LocalAppointment obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.doctorName)
      ..writeByte(1)
      ..write(obj.specialization)
      ..writeByte(2)
      ..write(obj.appointmentTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalAppointmentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
