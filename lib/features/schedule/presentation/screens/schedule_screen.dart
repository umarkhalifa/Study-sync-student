import 'dart:core';

import 'package:alhikmah_schedule_student/config/shared/loading_screen.dart';
import 'package:alhikmah_schedule_student/features/schedule/presentation/providers/schedule_provider.dart';
import 'package:alhikmah_schedule_student/utils/enum/app_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:solar_icons/solar_icons.dart';

import '../widgets/date_card.dart';
import '../widgets/schedule_card.dart';

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
      Provider.of<ScheduleProvider>(context, listen: false).init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final courseProv = Provider.of<ScheduleProvider>(context);
    final days = courseProv.getNext30Days();
    return Scaffold(
      backgroundColor: const Color(0xfff6f7fb),
      body: SafeArea(
        child: courseProv.appState == AppState.loading
            ? const LoadingScreen()
            : Material(
                color: const Color(0xff6BBD78),
                child: RefreshIndicator(
                  onRefresh: ()async{
                    await courseProv.refresh();
                  },
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                          "Hello ${FirebaseAuth.instance.currentUser?.displayName},",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context, '/profile');
                                    },
                                    child: const CircleAvatar(
                                      backgroundColor: Color(0xff0e2513),
                                      child: Icon(
                                        SolarIconsBold.user,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Text(
                                  DateFormat('EEEE dd MMMM,yyy').format(DateTime.now(),),
                              style: const TextStyle(
                                color: Colors.white
                              ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              RichText(
                                text: TextSpan(
                                  text: "You Have ",
                                  style: GoogleFonts.hankenGrotesk(
                                    fontSize: 26,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                  children: [
                                    TextSpan(
                                      text:
                                          "${courseProv.lectures.length} Classes\n",
                                      style: const TextStyle(
                                        color: Color(0xff0e2513),
                                      ),
                                    ),
                                    const TextSpan(text: "Waiting For You Today")
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Material(
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 60,
                                  width: MediaQuery.sizeOf(context).width,
                                  child: ListView.separated(
                                    itemBuilder: (context, index) {
                                      final selected = days[index].day ==
                                          courseProv.selectedDay.day;
                                      return GestureDetector(
                                        onTap: () {
                                          courseProv
                                              .updateSelectedDay(days[index]);
                                        },
                                        child: DateCard(
                                            selected: selected, day: days[index]),
                                      );
                                    },
                                    separatorBuilder: (_, __) {
                                      return const SizedBox(
                                        width: 15,
                                      );
                                    },
                                    itemCount: days.length,
                                    scrollDirection: Axis.horizontal,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.sizeOf(context).width,
                                  height: 1,
                                  color: Colors.grey.shade300,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  child: Row(
                                    children: [
                                      Text(
                                        DateFormat('EEEE, dd MMMM yyyy')
                                            .format(courseProv.selectedDay),
                                      ),
                                      const Spacer(),
                                      Text(
                                        "${courseProv.lectures.length} Classes Await",
                                        style: const TextStyle(
                                          color: Color(0xff0e2513),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.sizeOf(context).width,
                                  height: 1,
                                  color: Colors.grey.shade300,
                                ),
                                ListView.builder(
                                  itemCount: 11,
                                  // 11 hours from 8am to 6pm
                                  itemBuilder: (context, index) {
                                    final hour = index + 8; // Starting from 8am
                                    final lectureOccurrence = courseProv
                                        .getLectureOccurrenceForHour(hour);
                                    return ScheduleCard(
                                      hour: hour,
                                      lectureOccurrence: lectureOccurrence,
                                      selectedDay: courseProv.selectedDay,
                                    );
                                  },
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 15),
                                ),
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
    );
  }
}
