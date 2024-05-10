import 'package:alhikmah_schedule_student/features/authentication/domain/model/model.dart';
import 'package:alhikmah_schedule_student/utils/extensions/time.dart';
import 'package:flutter/material.dart';
import 'package:solar_icons/solar_icons.dart';

import 'course_detail_sheet.dart';

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({
    super.key,
    required this.hour,
    required this.lectureOccurrence,
    required this.selectedDay,
  });

  final int hour;
  final Lecture? lectureOccurrence;
  final DateTime selectedDay;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('${hour.toTime()} '),
        const SizedBox(
          width: 30,
          child: Divider(),
        ),
        Expanded(
          flex: 3,
          child: lectureOccurrence == null
              ? const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Divider(),
                )
              : Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: GestureDetector(
                    onTap: () async {
                      await showModalBottomSheet(
                          context: context,
                          builder: (context) => CourseDetailSheet(
                                lecture: lectureOccurrence!,
                                day: selectedDay.weekday,
                              ),
                          backgroundColor: Colors.black54,
                          isScrollControlled: true,
                          isDismissible: true);
                    },
                    child: Material(
                      color: const Color(0xffc8eacd),
                      elevation: 5,
                      shadowColor: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(8),
                      child: SizedBox(
                        width: MediaQuery.sizeOf(context).width,
                        child: Row(
                          children: [
                            const Material(
                              color: Color(0xff358442),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                bottomLeft: Radius.circular(5)
                              ),
                              child: SizedBox(
                                width: 5,
                                height: 100,
                              ),

                            ),
                            const SizedBox(width: 5,),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.all(10),

                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      lectureOccurrence?.title ?? "",
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff224529)),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          SolarIconsOutline.user,
                                          size: 17,
                                          color: Color(0xff224529),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(lectureOccurrence!.lecturer!.isEmpty
                                            ? 'Not Available'
                                            : '${lectureOccurrence?.lecturer}',
                                        style: const TextStyle(
                                          color: Color(0xff224529)
                                        ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
        )
      ],
    );
  }
}
