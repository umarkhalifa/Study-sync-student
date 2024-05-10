import 'package:alhikmah_schedule_student/features/profile/presentation/widgets/detail_column.dart';
import 'package:alhikmah_schedule_student/features/profile/presentation/widgets/logout_dialog.dart';
import 'package:alhikmah_schedule_student/features/schedule/presentation/providers/schedule_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solar_icons/solar_icons.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final courseProv = Provider.of<ScheduleProvider>(context);
    return Scaffold(
      backgroundColor: const Color(0xfff6f7fb),
      appBar: AppBar(
        backgroundColor: const Color(0xfff6f7fb),
        centerTitle: true,
        title: const Text(
          "Personal Information",
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: CircleAvatar(
                radius: 55,
                backgroundColor: Color(0xffcfe7da),
                child: Icon(
                  SolarIconsBold.user,
                  color: Colors.white,
                  size: 80,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            DetailColumn(
                label: 'Full Name',
                content: FirebaseAuth.instance.currentUser?.displayName ?? ""),
            DetailColumn(
                label: 'Level',
                content: '${courseProv.userProfile?.level ?? ""}'),
            DetailColumn(
                label: 'Programme',
                content: courseProv.userProfile?.programme ?? ''),
            DetailColumn(
                label: 'Matric No',
                content: courseProv.userProfile?.matricNo ?? ''),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () async {
                await showDialog(
                    context: context,
                    builder: (context) => const LogoutDialog());
              },
              child: Material(
                color: Colors.red.shade700,
                borderRadius: BorderRadius.circular(10),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        SolarIconsOutline.logout,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Text(
                        "Logout",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


