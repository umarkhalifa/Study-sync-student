import 'package:flutter/material.dart';
import 'package:solar_icons/solar_icons.dart';
class EmptyLectureState extends StatelessWidget {
  const EmptyLectureState({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery
          .sizeOf(context)
          .height * 0.4,
      width: MediaQuery
          .sizeOf(context)
          .width,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            SolarIconsOutline.calendarMark,
            size: 200,
            color: Color(0xff4f7950),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Lecture free day. Enjoy your day!",
            style: TextStyle(fontSize: 16, color: Color(0xff4f7950)),
          )
        ],
      ),
    );
  }
}
