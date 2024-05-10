import 'package:alhikmah_schedule_student/features/authentication/presentation/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class CourseSelection extends StatelessWidget {
  const CourseSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final courseProvider = Provider.of<AuthProvider>(context);
    return WillPopScope(
      onWillPop: () async{return false;  },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
                    color: Color(0xff5EB670),
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
                    ? const Color(0xffE3F5E5)
                    : Colors.transparent,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        course?.code ?? "",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        course?.title ?? "",
                        maxLines: 1,
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color:  Colors.black,
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
      ),
    );
  }
}
