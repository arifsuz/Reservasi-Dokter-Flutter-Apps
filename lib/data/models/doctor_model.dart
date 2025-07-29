import 'package:cloud_firestore/cloud_firestore.dart';

class Doctor {
  final String id;
  final String name;
  final String specialization;
  final String photoUrl;
  final String description;

  Doctor({
    required this.id,
    required this.name,
    required this.specialization,
    required this.photoUrl,
    required this.description,
  });

  factory Doctor.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Doctor(
      id: doc.id,
      name: data['name'] ?? 'No Name',
      specialization: data['specialization'] ?? 'No Specialization',
      photoUrl: data['photoUrl'] ?? '',
      description: data['description'] ?? 'No Description',
    );
  }
}