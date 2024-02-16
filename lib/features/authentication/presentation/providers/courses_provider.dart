import 'package:alhikmah_schedule_student/soft.dart';
import 'package:flutter/cupertino.dart';

class SelectCoursesProvider extends ChangeNotifier {
  Programme programme = programmes.first;
  final List<Course> selectedCourses = [];
  DateTime selectedDay = DateTime.now();

  // Update the users selected programme
  void selectProgramme(Programme newProgramme) {
    programme = newProgramme;
    notifyListeners();
  }

  // Update selected day
  void updateSelectedDay(DateTime date){
    selectedDay = date;
    notifyListeners();
  }

  /// Select and deselect courses
void updateSelectedCourse(Course course){
    if(selectedCourses.contains(course)){
      selectedCourses.remove(course);
      notifyListeners();
      return;
    }
    selectedCourses.add(course);
    notifyListeners();
}
}
