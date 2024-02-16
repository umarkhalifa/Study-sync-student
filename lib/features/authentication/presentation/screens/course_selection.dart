import 'package:alhikmah_schedule_student/features/authentication/presentation/providers/auth_provider.dart';
import 'package:alhikmah_schedule_student/features/authentication/presentation/providers/courses_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CourseSelection extends StatelessWidget {
  const CourseSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final courseProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Select Your Courses",
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
         Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: const Text(
                "Done",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff036000),
                ),
              ),
            ),
          ),
        ],
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          final course = courseProvider.programme?.courses![index];
          return GestureDetector(
            onTap: () {
              courseProvider.updateSelectedCourse(course!);
            },
            child: Material(
              color: courseProvider.selectedCourses.contains(course)
                  ? const Color(0xff036000).withOpacity(0.7)
                  : Colors.transparent,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course?.code ?? "",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: courseProvider.selectedCourses.contains(course)
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    Text(
                      course?.title ?? "",
                      maxLines: 1,
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: courseProvider.selectedCourses.contains(course)
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: courseProvider.programme?.courses?.length??0,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            height: 15,
          );
        },
      ),
    );
  }
}
