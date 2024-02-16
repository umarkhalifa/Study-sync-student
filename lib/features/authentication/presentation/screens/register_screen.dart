import 'package:alhikmah_schedule_student/config/shared/button.dart';
import 'package:alhikmah_schedule_student/config/shared/text_field.dart';
import 'package:alhikmah_schedule_student/features/authentication/presentation/providers/auth_provider.dart';
import 'package:alhikmah_schedule_student/features/authentication/presentation/screens/login.dart';
import 'package:alhikmah_schedule_student/utils/enum/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solar_icons/solar_icons.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  const Text(
                    "Hello",
                    style: TextStyle(
                        fontSize: 34,
                        color: Color(0xff036000),
                        fontWeight: FontWeight.w700),
                  ),
                  const Text(
                    "there!",
                    style: TextStyle(fontSize: 34, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Create an to access your course schedule and get real time updates on all your courses",
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ScheduleTextField(
                    prefixIcon: Icon(
                      SolarIconsOutline.user,
                      color: Colors.grey.shade400,
                    ),
                    hint: "Enter your full name",
                    controller: nameController,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ScheduleTextField(
                    prefixIcon: Icon(
                      SolarIconsOutline.letter,
                      color: Colors.grey.shade400,
                    ),
                    hint: "Enter your email address",
                    controller: emailController,
                    textInputType: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ScheduleTextField(
                    prefixIcon: Icon(
                      SolarIconsOutline.lock,
                      color: Colors.grey.shade400,
                    ),
                    hint: "Enter your password",
                    obscureText: true,
                    controller: passwordController,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      authProvider.register(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                        name: nameController.text.trim(),
                      );
                    },
                    child: ScheduleButton(
                      label: "Register",
                      loading: authProvider.appState == AppState.loading,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(color: Colors.grey.shade500),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                        child: const Text(
                          " Login",
                          style: TextStyle(
                            color: Color(0xff036000),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
