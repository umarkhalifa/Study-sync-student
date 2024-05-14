// Importing the 'developer' library from Dart which provides tools for logging, debugging, and profiling.

import 'dart:developer';

import 'package:alhikmah_schedule_student/features/authentication/domain/model/department.dart';
import 'package:alhikmah_schedule_student/utils/enum/app_firebase_exception_type.dart';
import 'package:alhikmah_schedule_student/utils/extensions/app_firebase_exceptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class AuthenticationDataSource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  /// Sign In
  Future<Either<AppFirebaseExceptionType, bool>> login(
      {required String email, required String password}) async {
    try {
      final user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      final users = await firebaseFirestore.collection("USERS").doc(
          user.user?.uid).get();
      if (users.exists) {
        // Update the user's token.
        await firebaseFirestore
            .collection("USERS")
            .doc(user.user?.uid)
            .update({'Token': await FirebaseMessaging.instance.getToken()});
      }
      // Return success.
      return Right(users.exists);
    } on FirebaseAuthException catch (error) {
      // Handle FirebaseAuth exceptions.
      log('FirebaseAuthException occurred: ${error.message}');
      return Left(error.appFirebaseExceptionType());
    } catch (error) {
      // Handle other exceptions.
      log('Unexpected error occurred during login: $error');
      return const Left(AppFirebaseExceptionType.networkUnavailable);
    }
  }

  /// Register user
  Future<Either<AppFirebaseExceptionType, String>> register(
      {required String email,
        required String password,
        required String name}) async {
    try {
      final user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await user.user?.updateDisplayName(name);

      return const Right('Account created successfully');
    } on FirebaseAuthException catch (error) {
      return Left(error.appFirebaseExceptionType());
    } catch (error) {
      return const Left(AppFirebaseExceptionType.networkUnavailable);
    }
  }

  /// Send reset password email
  Future<Either<AppFirebaseExceptionType, String>> forgotPassword(
      {required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return const Right('Password reset link sent successfully');
    } on FirebaseAuthException catch (error) {
      return Left(error.appFirebaseExceptionType());
    } catch (error) {
      return const Left(AppFirebaseExceptionType.networkUnavailable);
    }
  }

  /// Upload users, personal information
  Future<Either<String, String>> uploadPersonalInformation(
      {required String matric,
        required int level,
        required String programme,
        required List<String> courses}) async {
    try {
      await firebaseFirestore
          .collection("USERS")
          .doc(_firebaseAuth.currentUser?.uid)
          .set({
        'Matric No': matric,
        'Token': await FirebaseMessaging.instance.getToken(),
        'Level': level,
        'Programme': programme,
        'Courses': courses
      });
      return const Right('Personal Information uploaded successfully');
    } catch (error) {
      return const Left('Error uploading personal Information');
    }
  }


  /// Fetch List of Programmes in department with respective courses
  Future<Either<String, List<Department>>> fetchProgrammes() async {
    try {
      final data = await firebaseFirestore.collection("PROGRAMMES").get();
      return Right(data.docs.map((e) => Department.fromMap(e.data())).toList());
    }
    catch (error) {
      log(error.toString());
      return const Left('Error fetching courses');
    }
  }

  Future<Either<String, List<String>>> fetchCourses() async {
    try {
      final data = await firebaseFirestore.collection("CLASSES").get();
      return Right(data.docs.map((e) => e.id).toList());
    }
    catch (error) {
      log(error.toString());
      return const Left('Error fetching courses');
    }
  }


  Future<Either<String, String>> updateProfile(
      {String? programme, String? matricNo,int? level,List<String>? courses}) async {
    try {
      final body = {'Programme': programme, 'Matric No': matricNo, 'Level':level,
      "Courses":courses
      };
      body.removeWhere((key, value) => value == null);
      await firebaseFirestore
          .collection("USERS")
          .doc(_firebaseAuth.currentUser?.uid)
          .update(body);
      return const Right('Profile updated successfully');
    } catch (error) {
      log(error.toString());
      return const Left('Error updating Profile');
    }
  }
}
