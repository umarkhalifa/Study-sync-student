import 'package:alhikmah_schedule_student/features/profile/presentation/screens/profile_screen.dart';
import 'package:alhikmah_schedule_student/features/schedule/presentation/screens/schedule_screen.dart';
import 'package:flutter/material.dart';
import 'package:solar_icons/solar_icons.dart';
class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}
List<Widget> screens = [
  const ScheduleScreen(),
  const ProfileScreen(),
];
class _BottomBarState extends State<BottomBar> {
  final ValueNotifier<int> currentIndex = ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(valueListenable: currentIndex, builder: (context,value,child){
      return Scaffold(
        body: screens[value],
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            onTap: (index){
              currentIndex.value = index;
            },
            currentIndex: value,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(SolarIconsOutline.calendar),
                label: 'Schedule',
              ),
              BottomNavigationBarItem(
                icon: Icon(SolarIconsOutline.user),
                label: 'Profile',
              ),
            ]),

      );
    });
  }
}
