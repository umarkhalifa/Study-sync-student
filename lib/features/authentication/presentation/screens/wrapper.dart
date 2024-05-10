import 'package:alhikmah_schedule_student/config/services/shared_preference_service/shared_preference_service.dart';
import 'package:alhikmah_schedule_student/features/authentication/presentation/screens/auth_form.dart';
import 'package:alhikmah_schedule_student/features/authentication/presentation/screens/onboarding.dart';
import 'package:alhikmah_schedule_student/features/authentication/presentation/screens/personal_details.dart';
import 'package:alhikmah_schedule_student/features/schedule/presentation/screens/schedule_screen.dart';
import 'package:alhikmah_schedule_student/locator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppWrapper extends StatefulWidget {
  const AppWrapper({super.key});

  @override
  State<AppWrapper> createState() => _AppWrapperState();
}

class _AppWrapperState extends State<AppWrapper> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        /// Check  if user has opened onBoarding screen before
        if (locator<SharedPreferenceProvider>().viewedOnBoarding == false) {
          return const OnBoardingScreen();
        } else {
          if (snapshot.hasData) {
            /// Check if user has uploaded profile details
            if (locator<SharedPreferenceProvider>().completedProfile == false) {
              return const PersonalDetailsScreen();
            }
            return const ScheduleScreen();
          } else {
            return const AuthForm();
          }
        }
      },
    );
  }
}
