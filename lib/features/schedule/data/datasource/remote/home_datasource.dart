import 'dart:convert';
import 'dart:developer';

import 'package:alhikmah_schedule_student/soft.dart';
import 'package:alhikmah_schedule_student/utils/enum/app_firebase_exception_type.dart';
import 'package:alhikmah_schedule_student/utils/extensions/app_firebase_exceptions.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

class HomeDataSource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  /// Sign In
  Future<Either<AppFirebaseExceptionType, String>> login(
      {required String email, required String password}) async {
    try {
      final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email, password: password);
      final users = await firebaseFirestore.collection("USERS").doc(user.user?.uid).get();
      if(users.exists){
        await firebaseFirestore.collection("USERS").doc(user.user?.uid).update({
          'Token': await FirebaseMessaging.instance.getToken()
        });
      }
      return const Right('User logged in successfully');
    } on FirebaseAuthException catch (error) {
      log(error.message??'');
      return Left(error.appFirebaseExceptionType());
    } catch (error) {
      return const Left(AppFirebaseExceptionType.networkUnavailable);
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
