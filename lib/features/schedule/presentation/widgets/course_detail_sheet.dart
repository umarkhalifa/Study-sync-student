import 'package:alhikmah_schedule_student/utils/extensions/time.dart';
import 'package:flutter/material.dart';
import 'package:solar_icons/solar_icons.dart';

import '../../../authentication/domain/model/lecture.dart';
import 'course_detail_card.dart';

class CourseDetailSheet extends StatelessWidget {
  final Lecture lecture;
  final int day;

  const CourseDetailSheet(
      {super.key, required this.lecture, required this.day});

  @override
  Widget build(BuildContext context) {
    final occurrence =
        lecture.occurrences.where((element) => element.day == day).first;
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 500),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(30),
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Material(
                  color: const Color(0xff358442),
                  borderRadius: BorderRadius.circular(30),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text(
                      lecture.id,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              lecture.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xff031628),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CourseDetailCard(
              iconData: SolarIconsOutline.clockSquare,
              detail: '${occurrence.start.toTime()}-${occurrence.end.toTime()}',
            ),
            CourseDetailCard(
              iconData: SolarIconsOutline.mapPoint,
              detail: occurrence.venue,
            ),
            CourseDetailCard(
              iconData: SolarIconsOutline.phone,
              detail: lecture.phoneNumber!.isEmpty
                  ? 'Not Available'
                  : lecture.phoneNumber!,
              isCall: true,
            ),
            CourseDetailCard(
              iconData: SolarIconsOutline.user,
              detail: lecture.lecturer!.isEmpty
                  ? 'Not Available'
                  : lecture.lecturer!,
            ),
          ],
        ),
      ),
    );
  }
}

