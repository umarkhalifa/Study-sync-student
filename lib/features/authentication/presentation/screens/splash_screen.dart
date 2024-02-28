import 'package:alhikmah_schedule_student/config/services/shared_preference_service/shared_preference_service.dart';
import 'package:alhikmah_schedule_student/features/authentication/presentation/screens/wrapper.dart';
import 'package:alhikmah_schedule_student/locator.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashAnimation();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await locator<SharedPreferenceProvider>().init();
    });
  }

  void splashAnimation() async {
    await Future.delayed(const Duration(seconds: 5)).then((value) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const AppWrapper(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height,
      width: MediaQuery.sizeOf(context).width,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            "assets/images/background.jpg",
          ),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
              Colors.black38, BlendMode.color),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/alhikmah_logo.jpg",height: 200,)
        ],
      ),
    );
  }
}
