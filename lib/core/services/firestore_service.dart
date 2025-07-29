import 'package:cloud_firestore/cloud_firestore.dart';
import '../../data/models/doctor_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Doctor>> getDoctors() async {
    try {
      QuerySnapshot snapshot = await _db.collection('doctors').get();
      return snapshot.docs.map((doc) => Doctor.fromFirestore(doc)).toList();
    } catch (e) {
      print('Error getting doctors: $e');
      return [];
    }
  }

  Stream<List<DateTime>> getBookedSlots(String doctorId, DateTime date) {
    DateTime startOfDay = DateTime(date.year, date.month, date.day);
    DateTime endOfDay = startOfDay.add(const Duration(days: 1));

    return _db
        .collection('bookings')
        .where('doctorId', isEqualTo: doctorId)
        .where('appointmentTime',
            isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay))
        .where('appointmentTime', isLessThan: Timestamp.fromDate(endOfDay))
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return (doc['appointmentTime'] as Timestamp).toDate();
      }).toList();
    });
  }

  Future<bool> createBooking({
    required String doctorId,
    required String doctorName,
    required DateTime appointmentTime,
    required String patientName,
    required int patientAge,
    required String patientGender,
  }) async {
    try {
      await _db.collection('bookings').add({
        'doctorId': doctorId,
        'doctorName': doctorName,
        'appointmentTime': Timestamp.fromDate(appointmentTime),
        'patientName': patientName,
        'patientAge': patientAge,
        'patientGender': patientGender,
        'createdAt': FieldValue.serverTimestamp(),
        'status': 'confirmed',
      });
      return true;
    } catch (e) {
      print('Error creating booking: $e');
      return false;
    }
  }
}