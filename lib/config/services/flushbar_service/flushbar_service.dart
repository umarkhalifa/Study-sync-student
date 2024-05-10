import 'package:alhikmah_schedule_student/main.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class FlushBarService{
  void showFlushError({required String title}){
    /// Show error flushBar
    Flushbar(
      backgroundColor: const Color(0XFFB3261E),
      duration: const Duration(seconds: 4),
      dismissDirection: FlushbarDismissDirection.VERTICAL,
      flushbarPosition: FlushbarPosition.TOP,
      shouldIconPulse: true,
      icon: const Icon(
        Icons.error,
        size: 20,
        color: Colors.white,
      ),
      title: 'Error',
      message:title,
    ).show(navigatorKey.currentContext!);
  }

  Future<void> showFlushSuccess({required String title})async{
    /// Show success flushBar
    await Flushbar(
      backgroundColor: const Color(0XFF12B76A),
      duration: const Duration(seconds: 4),
      dismissDirection: FlushbarDismissDirection.VERTICAL,
      flushbarPosition: FlushbarPosition.TOP,
      shouldIconPulse: true,
      icon: const Icon(
        Icons.check,
        size: 20,
        color: Colors.white,
      ),
      title: 'Success',
      message:title,
    ).show(navigatorKey.currentContext!);
  }
}