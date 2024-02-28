import 'dart:core';
import 'dart:math';

import 'package:alhikmah_schedule_student/features/authentication/presentation/providers/courses_provider.dart';
import 'package:alhikmah_schedule_student/soft.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:solar_icons/solar_icons.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<SelectCoursesProvider>(context, listen: false).init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final courseProv = Provider.of<SelectCoursesProvider>(context);
    final days = courseProv.getNext30Days();
    Random random = Random();
    return Scaffold(
      backgroundColor: const Color(0xfff6f7fb),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const UserDetailsCard(),
              Builder(builder: (context) {
                if (courseProv.showCalendar) {
                  return TableCalendar(
                    firstDay: DateTime.utc(2010, 10, 16),
                    lastDay: DateTime.utc(2030, 3, 14),
                    focusedDay: DateTime.now(),
                    selectedDayPredicate: (day) {
                      return isSameDay(courseProv.selectedDay, day);
                    },
                    onDaySelected: (date, _) {
                      courseProv.updateSelectedDay(date);
                    },
                    calendarStyle: const CalendarStyle(
                      todayDecoration: BoxDecoration(
                        color: Color(0xffd4f8d4),
                        shape: BoxShape.circle,
                      ),
                      todayTextStyle: TextStyle(
                        color: Colors.black87,
                      ),
                      selectedDecoration: BoxDecoration(
                        color: Color(0xff036000),
                        shape: BoxShape.circle,
                      ),
                    ),
                  );
                } else {
                  return SizedBox(
                    height: 90,
                    width: MediaQuery.sizeOf(context).width,
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        final selected =
                            days[index].day == courseProv.selectedDay.day;
                        return GestureDetector(
                          onTap: () {
                            courseProv.updateSelectedDay(days[index]);
                          },
                          child: DateCard(selected: selected, day: days[index]),
                        );
                      },
                      separatorBuilder: (_, __) {
                        return const SizedBox(
                          width: 5,
                        );
                      },
                      itemCount: days.length,
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                    ),
                  );
                }
              }),
              courseProv.myLectures.isNotEmpty
                  ? Column(
                      children: List.generate(
                        courseProv.myLectures.length,
                        (index) {
                          final lecture = courseProv.myLectures[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 7.0, horizontal: 15),
                            child:
                                ScheduleCard(lecture: lecture, random: random),
                          );
                        },
                      ),
                    )
                  : const EmptyLectureState()
            ],
          ),
        ),
      ),
    );
  }
}

class DateCard extends StatelessWidget {
  const DateCard({
    super.key,
    required this.selected,
    required this.day,
  });

  final bool selected;
  final DateTime day;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected
          ? const Color(0xffcfe7da)
          : const Color(0xffecedf2),
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
        width: 65,
        child: Padding(
          padding:
              const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Text(
                day.day.toString(),
                style: TextStyle(
                  color: selected
                      ? const Color(0xff12262f)
                      : const Color(0xff585d73),
                ),
              ),
              const Spacer(),
              Text(
                DateFormat('EEE').format(day),
                style: TextStyle(
                  color: selected
                      ? const Color(0xff12262f)
                      : const Color(0xff585d73),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class EmptyLectureState extends StatelessWidget {
  const EmptyLectureState({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.4,
      width: MediaQuery.sizeOf(context).width,
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

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({
    super.key,
    required this.lecture,
    required this.random,
  });

  final Lecture lecture;
  final Random random;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      width: MediaQuery.sizeOf(context).width,
      child: Material(
        color: Colors.white,
        shadowColor: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
        elevation: 6,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "${lecture.start}-${lecture.end}",
                    style: const TextStyle(
                      color: Color(0xff8fa0b2),
                    ),
                  ),
                  const Spacer(),
                  Material(
                    borderRadius: BorderRadius.circular(30),
                    color: Color.fromARGB(
                      255,
                      random.nextInt(256),
                      // Generates a random value for the red channel (0-255)
                      random.nextInt(256),
                      // Generates a random value for the green channel (0-255)
                      random.nextInt(
                          256), // Generates a random value for the blue channel (0-255)
                    ).withOpacity(0.1),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5),
                      child: Text(
                        lecture.course?.code ?? "",
                        style: const TextStyle(
                            color: Colors.black87, fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                lecture.course?.title ?? "",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  Text(
                    lecture.toTime(),
                    style: TextStyle(
                      color: lecture.toColor(),
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    SolarIconsOutline.mapPoint,
                    size: 17,
                    color: Color(0xff8fa0b2),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    lecture.venue ?? "",
                    style: const TextStyle(
                      color: Color(0xff8fa0b2),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserDetailsCard extends StatelessWidget {
  const UserDetailsCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final courseProv = Provider.of<SelectCoursesProvider>(context);

    return Container(
      height: MediaQuery.sizeOf(context).height * 0.2,
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xff151515), Color(0xff30603f)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
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
                value: courseProv.showCalendar,
                borderRadius: 30.0,
                activeColor: const Color(0xff4f7950),
                inactiveColor: const Color(0xff4f7950),
                padding: 8.0,
                activeIcon: const Icon(Icons.list),
                inactiveIcon: const Icon(SolarIconsOutline.calendar),
                showOnOff: false,
                onToggle: (val) {
                  courseProv.updateCalendar();
                  // setState(() {
                  //   status = val;
                  // });
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}

extension Lectures on Lecture {
  String toTime() {
    if (DateTime.now().hour < int.parse(start!.substring(0, 1))) {
      return 'Upcoming';
    } else if (DateTime.now().hour > int.parse(end!.substring(0, 1))) {
      return 'Completed';
    } else {
      return 'Ongoing';
    }
  }
}

extension LectureColor on Lecture {
  Color toColor() {
    if (DateTime.now().hour < int.parse(start!.substring(0, 1))) {
      return const Color(0xff036000);
    } else if (DateTime.now().hour > int.parse(end!.substring(0, 1))) {
      return const Color(0xffFF7F7F);
    } else {
      return const Color(0xfffffdd0);
    }
  }
}
