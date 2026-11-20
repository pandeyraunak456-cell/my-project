import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ResumeService {
  static Future<String> uploadResume({
    required Uint8List bytes,
    required String fileName,
    required Map<String, String> details,
  }) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw Exception(
        'Please login with Firebase Authentication first.'
      );
    }

    final safeName = fileName.replaceAll(
      RegExp(r'[^a-zA-Z0-9._-]'),
      '_',
    );

    final ref = FirebaseStorage.instance
        .ref()
        .child('users/${user.uid}/resumes/$safeName');

    final snapshot = await ref.putData(
      bytes,
      SettableMetadata(
        contentType: 'application/pdf',
      ),
    );

    final downloadUrl = await snapshot.ref.getDownloadURL();

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('resumes')
        .doc('latest')
        .set({
      'fileName': fileName,
      'resumeUrl': downloadUrl,
      'name': details['name'] ?? '',
      'email': details['email'] ?? '',
      'phone': details['phone'] ?? '',
      'education': details['education'] ?? '',
      'skills': details['skills'] ?? '',
      'experience': details['experience'] ?? '',
      'updatedAt': FieldValue.serverTimestamp(),
    });

    return downloadUrl;
  }
}