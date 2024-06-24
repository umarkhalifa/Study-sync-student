import 'package:alhikmah_schedule_student/features/profile/presentation/provider/profile_provider.dart';
import 'package:alhikmah_schedule_student/features/schedule/presentation/providers/schedule_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileCourseScreen extends StatefulWidget {
  const ProfileCourseScreen({super.key});

  @override
  State<ProfileCourseScreen> createState() => _ProfileCourseScreenState();
}

class _ProfileCourseScreenState extends State<ProfileCourseScreen> {
  @override
  void initState() {
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
                return Consumer<ProfileProvider>(
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

    );
  }
}
