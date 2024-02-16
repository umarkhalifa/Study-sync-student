import 'dart:developer';

import 'package:alhikmah_schedule_student/soft.dart';
import 'package:alhikmah_schedule_student/utils/enum/app_firebase_exception_type.dart';
import 'package:alhikmah_schedule_student/utils/extensions/app_firebase_exceptions.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthenticationDataSource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  /// Sign In
  Future<Either<AppFirebaseExceptionType, String>> login(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: 'khalifa@gmail.com', password: 'password');
      return const Right('User logged in successfully');
    } on FirebaseAuthException catch (error) {
      log(error.message??'');
      return Left(error.appFirebaseExceptionType());
    } catch (error) {
      return const Left(AppFirebaseExceptionType.networkUnavailable);
    }
  }

  /// Register
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
////firebaseFirestore.collection("USERS").doc(user.user?.uid).set({
//
//       });
  ///Forgot Password
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

  Future<Either<String, String>>uploadPersonalInformation({required String matric,required int level,required String programme,required List<Course> courses})async{
    try{
      await firebaseFirestore.collection("USERS").doc(_firebaseAuth.currentUser?.uid).set({
        'Matric No':matric,
        'Level':level,
        'Programme':programme,
        'Courses': courses.map((e) => e.id).toList()
      });
      return const Right('Personal Information uploaded successfully');
    }catch(error){
      return const Left('Error uploading personal Information');
    }
  }

  Future<Either<String, List<Programme>>> fetchProgrammes()async{
    try{
      final data = await firebaseFirestore.collection("PROGRAMMES").get();

      return Right((data.docs).map((e) => Programme.fromMap(e.data())).toList());
    }catch(error){
      return const Left('Error fetching programmes');
    }
  }


}
