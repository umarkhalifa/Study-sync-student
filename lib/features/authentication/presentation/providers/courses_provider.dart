import 'package:alhikmah_schedule_student/soft.dart';
import 'package:flutter/cupertino.dart';

class SelectCoursesProvider extends ChangeNotifier {
  DateTime selectedDay = DateTime.now();
  bool showCalendar = false;
  List<Lecture> myLectures = [];
  void updateCalendar(){
    showCalendar = !showCalendar;
    notifyListeners();
  }

  // Update selected day
  void updateSelectedDay(DateTime date){
    selectedDay = date;
    myLectures = lectures.where((element) => element.day == date.weekday).toList();
    notifyListeners();
  }

  void init(){
    myLectures = lectures.where((element) => element.day == selectedDay.weekday).toList();
    notifyListeners();
  }

  List<DateTime> getNext30Days() {
    List<DateTime> next30Days = [];

    // Get the current date
    DateTime currentDate = DateTime.now();

    // Generate the next 30 days
    for (int i = 0; i < 29; i++) {
      DateTime nextDate = currentDate.add(Duration(days: i));
      next30Days.add(nextDate);
    }

    return next30Days;
  }


}
