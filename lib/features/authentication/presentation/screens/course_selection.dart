import 'package:alhikmah_schedule_student/features/authentication/presentation/providers/auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CourseSelection extends StatelessWidget {
  const CourseSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
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
                onTap: () {
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
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("CLASSES").snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(
                color: Colors.green.shade700,
              );
            } else {
              List<String>? courses =
                  snapshot.data?.docs.map((e) => e.id).toList();
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, mainAxisSpacing: 5, childAspectRatio: 2),
                itemBuilder: (context, index) {
                  return Consumer<AuthProvider>(
                      builder: (context, prov, child) {
                    return GestureDetector(
                      onTap: ()=> prov.updateCourse(courses?[index]??""),
                      child: Chip(
                        label: Text(
                          courses?[index] ?? "",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff0e2513),
                          ),
                        ),
                        backgroundColor:
                            prov.selectedCourses.contains(courses?[index])
                                ? Colors.green.withOpacity(0.6)
                                : Colors.white,
                      ),
                    );
                  });
                },
                itemCount: courses?.length ?? 0,
              );
            }
          },
        ),
      ),
    );
  }
}
