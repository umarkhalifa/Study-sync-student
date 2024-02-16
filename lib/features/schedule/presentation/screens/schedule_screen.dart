import 'package:alhikmah_schedule_student/features/authentication/presentation/providers/courses_provider.dart';
import 'package:alhikmah_schedule_student/utils/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solar_icons/solar_icons.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final courseProv = Provider.of<SelectCoursesProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TableCalendar(
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: DateTime.now(),
                selectedDayPredicate: (day) {
                  return isSameDay(courseProv.selectedDay, day);
                },
                onDaySelected: (date, _) {
                  // courseProv.updateSelectedDay(date);
                  LocalNotificationService().scheduleDailyTenAMNotification();
                },
                calendarStyle: const CalendarStyle(
                  todayDecoration: BoxDecoration(
                      color: Color(0xffd4f8d4), shape: BoxShape.circle),
                  todayTextStyle: TextStyle(color: Colors.black87),
                  selectedDecoration: BoxDecoration(
                      color: Color(0xff036000), shape: BoxShape.circle),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  "Schedule",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
              Column(
                children: List.generate(3, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 15),
                    child: SizedBox(
                      height: 100,
                      child: Material(
                        color: const Color(0xffd4f8d4).withOpacity(0.5),
                        borderRadius: BorderRadius.circular(16),
                        child: Row(
                          children: [
                            Material(
                              color: const Color(0xff036000),
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(16),
                                topLeft: Radius.circular(16),
                              ),
                              child: SizedBox(
                                width: 10,
                                height: MediaQuery.sizeOf(context).height,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "MAT 201",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "Mathematical Methods 1",
                                    style: TextStyle(color: Colors.black87),
                                  ),
                                  Row(
                                    children: [
                                      Icon(SolarIconsOutline.clockCircle,
                                          size: 17),
                                      SizedBox(width: 5),
                                      Text("09:00-10:00"),
                                      SizedBox(width: 15),
                                      Icon(SolarIconsOutline.mapPoint,
                                          size: 17),
                                      SizedBox(width: 5),
                                      Text("LR 13")
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
