import 'package:alhikmah_schedule_student/features/authentication/presentation/providers/auth_provider.dart';
import 'package:alhikmah_schedule_student/features/authentication/presentation/screens/login.dart';
import 'package:alhikmah_schedule_student/features/authentication/presentation/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthForm extends StatelessWidget {
  const AuthForm({super.key});
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Builder(
      builder: (context) {
        if (authProvider.authState == AuthState.register) {
          return const RegisterScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
