import 'package:alhikmah_schedule_student/features/profile/presentation/provider/profile_provider.dart';
import 'package:alhikmah_schedule_student/features/schedule/presentation/providers/schedule_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class ProfileCourseScreen extends StatefulWidget {
  const ProfileCourseScreen({super.key});

  @override
  State<ProfileCourseScreen> createState() => _ProfileCourseScreenState();
}

class _ProfileCourseScreenState extends State<ProfileCourseScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ProfileProvider>(context, listen: false).getCourses(
        userCourses: Provider.of<ScheduleProvider>(context, listen: false)
                .userProfile
                ?.courses ??
            [],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<ProfileProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Edit Profile",
          style: TextStyle(fontSize: 18),
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              prov.updateCourses();
              Navigator.pop(context);
            },
            child: const Text(
              "Save",
              style: TextStyle(
                  color: Color(0xff036000), fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(
            width: 15,
          )
        ],
      ),
      body: SafeArea(
        child: Builder(builder: (context) {
          if (prov.loading) {
            return const Center(
              child: SpinKitRotatingCircle(
                color: Color(0xff036000),
              ),
            );
          } else {
            return ListView.separated(
              itemBuilder: (context, index) {
                final course = prov.courses[index];
                return GestureDetector(
                  onTap: () {
                    prov.updateCourse(course);
                  },
                  child: Material(
                      color: prov.selectedCourses.contains(course)
                          ? const Color(0xffE3F5E5)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(5),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5.0, vertical: 12),
                        child: Text(course),
                      )),
                );
              },
              separatorBuilder: (_, __) {
                return const SizedBox(
                  height: 20,
                );
              },
              itemCount: prov.courses.length,
              padding: const EdgeInsets.all(20),
            );
          }
        }),
      ),
    );
  }
}
