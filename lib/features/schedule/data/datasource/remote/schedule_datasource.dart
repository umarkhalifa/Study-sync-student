import 'dart:developer';

import 'package:alhikmah_schedule_student/features/authentication/domain/model/model.dart';
import 'package:alhikmah_schedule_student/features/schedule/domain/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ScheduleDataSource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;


  /// Fetch Users Profile Details
  Future<Either<String, UserProfile>> fetchUserDetails() async {
    try {
      final data = await firebaseFirestore
          .collection("USERS")
          .doc(_firebaseAuth.currentUser?.uid)
          .get();
      return Right(UserProfile.fromMap(data.data()!));
    } catch (error) {
      log(error.toString());
      return const Left("Error fetching user details");
    }
  }

  /// Fetch Users Lectures
  Future<Either<String, List<Lecture>>> fetchLectures(
      {required String course, required List<String> courses}) async {
    try {
      // Fetch lectures from Firestore
      final List<Lecture> timeTable = [];
      final collection = firebaseFirestore.collection("CLASSES");
      for (var element in courses) {
        final lecture = await collection.doc(element).get();
        timeTable.add(Lecture.fromMap(lecture.data()!));
      }
      return Right(timeTable);
    } catch (error) {
      log(error.toString());
      return const Left('Error fetching programmes');
    }
  }
}
