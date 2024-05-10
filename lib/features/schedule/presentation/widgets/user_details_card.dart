import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:solar_icons/solar_icons.dart';

class UserDetailsCard extends StatelessWidget {
  final VoidCallback onChanged;
  final bool showCalendar;

  const UserDetailsCard({
    super.key,
    required this.onChanged,
    required this.showCalendar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.2,
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xff151515)),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Material(
                color: const Color(0xff2b3a2c),
                borderRadius: BorderRadius.circular(10),
                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(
                    SolarIconsBold.user,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    FirebaseAuth.instance.currentUser?.displayName ?? '',
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  const Text(
                    "STUDENT",
                    style: TextStyle(color: Color(0XFFfbdc99), fontSize: 14),
                  )
                ],
              ),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              const Text(
                "Schedule",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              FlutterSwitch(
                width: 70.0,
                height: 40.0,
                valueFontSize: 25.0,
                value: showCalendar,
                borderRadius: 30.0,
                activeColor: const Color(0xff363636),
                inactiveColor: const Color(0xff363636),
                padding: 8.0,
                activeIcon: const Icon(Icons.list),
                inactiveIcon: const Icon(SolarIconsOutline.calendar),
                showOnOff: false,
                onToggle: (val) {
                  onChanged();
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
