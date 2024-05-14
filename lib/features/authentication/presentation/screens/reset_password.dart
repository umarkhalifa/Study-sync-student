import 'package:alhikmah_schedule_student/config/shared/button.dart';
import 'package:alhikmah_schedule_student/config/shared/text_field.dart';
import 'package:alhikmah_schedule_student/features/authentication/presentation/providers/auth_provider.dart';
import 'package:alhikmah_schedule_student/utils/enum/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        title: const Text(
          "Reset Password",
          style: TextStyle(fontSize: 17),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              const Text(
                "Enter the email used to register your account so a password reset mail can be sent",
              ),
              const SizedBox(
                height: 60,
              ),
              ScheduleTextField(
                hint: "Email Address",
                controller: controller,
              ),
              const SizedBox(
                height: 70,
              ),
              ScheduleButton(
                label: "Forgot Password",
                loading: prov.appState == AppState.loading,
                onPressed: (){
                  prov.forgotPassword(email: controller.text);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
