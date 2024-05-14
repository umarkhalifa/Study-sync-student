import 'package:alhikmah_schedule_student/features/profile/presentation/provider/profile_provider.dart';
import 'package:alhikmah_schedule_student/features/profile/presentation/widgets/detail_column.dart';
import 'package:alhikmah_schedule_student/features/profile/presentation/widgets/logout_dialog.dart';
import 'package:alhikmah_schedule_student/features/schedule/presentation/providers/schedule_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:solar_icons/solar_icons.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final programmeController = TextEditingController();
  final matricController = TextEditingController();
  final levelController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final user =
        Provider.of<ScheduleProvider>(context, listen: false).userProfile;
    programmeController.text = user?.programme ?? '';
    matricController.text = user?.matricNo ?? "";
    levelController.text = user?.level.toString() ?? "";
  }

  @override
  Widget build(BuildContext context) {
    final profileProv = Provider.of<ProfileProvider>(context);
    return Scaffold(
      backgroundColor: const Color(0xfff6f7fb),
      appBar: AppBar(
        backgroundColor: const Color(0xfff6f7fb),
        centerTitle: true,
        title: const Text(
          "Personal Information",
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              profileProv.updateProfile(
                  programme: programmeController.text,
                  matricNo: matricController.text,
                  level: int.parse(levelController.text));
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
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        child: Stack(
          children: [
            SingleChildScrollView(
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
                    controller: TextEditingController(
                      text: FirebaseAuth.instance.currentUser?.displayName,
                    ),
                    enabled: false,
                  ),
                  DetailColumn(
                    label: 'Level',
                    controller: levelController,
                    textInputType: TextInputType.number,
                  ),
                  DetailColumn(
                    label: 'Programme',
                    controller: programmeController,
                  ),
                  DetailColumn(
                    label: 'Matric No',
                    controller: matricController,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/profileCourse');
                      },
                      child: const Padding(
                        padding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.add_circle_outline,
                              size: 15,
                              color: Color(0xff036000),
                            ),
                            Text(
                              "Select Courses",
                              style: TextStyle(color: Color(0xff036000)),
                            ),
                          ],
                        ),
                      ),
                    ),
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
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
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Visibility(
                visible: profileProv.loading,
                child: Container(
                  color: Colors.black26,
                  child: const Center(
                    child: SpinKitRotatingCircle(
                      color: Color(0xff036000),
                    ),
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
