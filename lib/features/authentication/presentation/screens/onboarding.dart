import 'package:alhikmah_schedule_student/config/services/shared_preference_service/shared_preference_service.dart';
import 'package:alhikmah_schedule_student/features/authentication/presentation/screens/login.dart';
import 'package:alhikmah_schedule_student/features/authentication/presentation/screens/register_screen.dart';
import 'package:alhikmah_schedule_student/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

List<Map<String, dynamic>> onBoardingData = [
  {
    'title': "Course Schedule at Your Fingertips",
    'description':
        "Access your course schedule anytime, anywhere, all in one place.",
    'image': "assets/images/onboarding1.svg"
  },
  {
    'title': "Personalized Notifications",
    'description':
        "Stay ahead with personalized reminders for lectures, exams, and assignments.",
    'image': "assets/images/onboarding2.svg"
  },
  {
    'title': "Simplified Course Management",
    'description':
        "Effortlessly view and manage your course schedule in one convenient location.",
    'image': "assets/images/onboarding1.svg"
  },
];

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController controller = PageController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Image.asset(
              'assets/images/alhikmah_logo.jpg',
              height: 100,
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.6,
              child: PageView.builder(
                controller: controller,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.4,
                        child: SvgPicture.asset(
                          onBoardingData[index]['image'],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text(
                          onBoardingData[index]['title'],
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text(
                          onBoardingData[index]['description'],
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  );
                },
                itemCount: onBoardingData.length,
              ),
            ),
            const Spacer(),
            SmoothPageIndicator(
              controller: controller,
              count: onBoardingData.length,
              effect: SwapEffect(
                  activeDotColor: const Color(0xff036000),
                  dotHeight: 10,
                  dotWidth: 10,
                  dotColor: Colors.grey.shade300),
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      locator<SharedPreferenceProvider>().setOnBoarding();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen()
                        ),
                      );
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                          fontSize: 16,
                          color: Color(0xff036000),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      locator<SharedPreferenceProvider>().setOnBoarding();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Register",
                      style: TextStyle(
                          fontSize: 16,
                          color: Color(0xff036000),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
