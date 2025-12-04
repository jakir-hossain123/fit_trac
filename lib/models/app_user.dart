import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String uid;
  final String firstName;
  final String lastName;
  final DateTime dateOfBirth;
  final String email;
  final DateTime createdAt;

  AppUser({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.email,
    required this.createdAt,
  });

  // to save new user data to firestore
  Map<String, dynamic> toFirestore() {
    return {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'email': email,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }

  // to read user data from firestore
  factory AppUser.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    if (data == null) {
      throw Exception("User data is null");
    }

    // Firestore  DateTime purse
    DateTime parsedDob;
    try {
      //Firestore as ISO String
      parsedDob = DateTime.parse(data['dateOfBirth'] as String);
    } catch (_) {
      // if pursing failed
      parsedDob = DateTime(2000, 1, 1);
    }

    return AppUser(
      uid: data['uid'] ?? doc.id,
      firstName: data['firstName'] ?? 'N/A',
      lastName: data['lastName'] ?? 'N/A',
      dateOfBirth: parsedDob,
      email: data['email'] ?? 'N/A',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}