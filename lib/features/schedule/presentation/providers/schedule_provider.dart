// Import the developer library for logging
import 'dart:developer';

// Import the FlushBarService for showing flushbar notifications
import 'package:alhikmah_schedule_student/config/services/flushbar_service/flushbar_service.dart';

// Import the LocalPushNotifications for push notifications
import 'package:alhikmah_schedule_student/config/services/push_notification_service/local_push_notifications.dart';

// Import the user model
import 'package:alhikmah_schedule_student/features/authentication/domain/model/model.dart';

// Import the schedule repository implementation
import 'package:alhikmah_schedule_student/features/schedule/data/repository_impl/schedule_repository_impl.dart';

// Import the locator for dependency injection
import 'package:alhikmah_schedule_student/locator.dart';

// Import the app state enum
import 'package:alhikmah_schedule_student/utils/enum/app_state.dart';

// Import the Cupertino library for Cupertino widgets
import 'package:flutter/cupertino.dart';

// Import the url_launcher for launching URLs
import 'package:url_launcher/url_launcher.dart';

// Import the user model from the domain
import '../../domain/model/user.dart';

// Define the ScheduleProvider class that extends ChangeNotifier
class ScheduleProvider extends ChangeNotifier {
  // Define the setters
  final _homeRepo = locator<ScheduleRepositoryImpl>();
  final _flushBarService = locator<FlushBarService>();

  // Define the lists for lectures, classes, and time table
  List<Lecture> _timeTable = [];
  List<Lecture> _lectures = [];

  // Define the selected day and user profile
  DateTime _selectedDay = DateTime.now();
  UserProfile? _profile;

  // Define the app state and show calendar boolean
  AppState _appState = AppState.idle;
  bool _showCalendar = false;

  // Define the getters for the lists, selected day, user profile, app state, and show calendar
  List<Lecture> get lectures => _lectures;
  DateTime get selectedDay => _selectedDay;
  UserProfile? get userProfile => _profile;
  AppState get appState => _appState;
  bool get showCalendar => _showCalendar;

  // Define the updateCalendar method to toggle the show calendar boolean
  void updateCalendar() {
    _showCalendar = !showCalendar;
    notifyListeners();
  }

  // Define the makePhoneCall method to make a phone call
  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  // Define the fetchUserDetails method to fetch user details
  Future<void> fetchUserDetails() async {
    final data = await _homeRepo.fetchUserProfile();
    data.fold(
          (l) => _flushBarService.showFlushError(title: l),
          (r) => _profile = r,
    );
  }

  // Define the fetchTimeTable method to fetch the time table
  Future<void> fetchTimeTable() async {
    final data = await _homeRepo.fetchLectures(
        course: _profile!.programme!, courses: _profile!.courses!);
    data.fold(
          (l) => _flushBarService.showFlushError(title: l),
          (r) => _timeTable = r,
    );
  }

  Future<void> setNotifications() async {
    for (var course in _timeTable) {
      for (var element in course.occurrences) {
        LocalNotificationService().scheduleDailyTenAMNotification(
            day: element.day, hour: element.start, course: course.id);
        log('done');
      }
    }
  }

  // Define the updateSelectedDay method to update the selected day
  void updateSelectedDay(DateTime date) {
    _selectedDay = date;
    sortTimeTable();
    // myLectures = lectures.where((element) => element.day == date.weekday).toList();
    notifyListeners();
  }

  // Define the sortTimeTable method to sort the time table
  Future<void> sortTimeTable({bool? includesToday}) async {
    _lectures = await _homeRepo.fetchTimeTale(
        day: selectedDay.weekday, lectures: _timeTable);
  }

  // Define the init method to initialize the provider
  Future<void> init() async {
    _appState = AppState.loading;
    notifyListeners();
    await fetchUserDetails();
    await fetchTimeTable();
    await setNotifications();
    await sortTimeTable(includesToday: true);
    _appState = AppState.idle;
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

  Lecture? getLectureOccurrenceForHour(int hour) {
    for (final lecture in lectures) {
      for (final occurrence in lecture.occurrences) {
        if (occurrence.day == selectedDay.weekday) {
          if (occurrence.start <= hour && occurrence.end > hour) {
            return lecture;
          }
        }
      }
    }
    return null;
  }
}
