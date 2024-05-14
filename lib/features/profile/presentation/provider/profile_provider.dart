import 'package:alhikmah_schedule_student/config/services/flushbar_service/flushbar_service.dart';
import 'package:alhikmah_schedule_student/features/authentication/data/repository_impl/auth_repository_impl.dart';
import 'package:alhikmah_schedule_student/features/schedule/domain/model/user.dart';
import 'package:alhikmah_schedule_student/features/schedule/presentation/providers/schedule_provider.dart';
import 'package:alhikmah_schedule_student/locator.dart';
import 'package:flutter/foundation.dart';

class ProfileProvider extends ChangeNotifier {
  final AuthRepositoryImpl _authRepositoryImpl = locator<AuthRepositoryImpl>();
  final _flushBarService = locator<FlushBarService>();

  UserProfile? get profile => locator<ScheduleProvider>().userProfile;
  List<String> _courses = [];
  List<String> _selectedCourses = [];

  List<String> get courses => _courses;

  List<String> get selectedCourses => _selectedCourses;

  bool _loading = false;

  bool get loading => _loading;

  Future<void> updateProfile(
      {String? programme, String? matricNo, int? level}) async {
    _loading = true;
    notifyListeners();
    final data = await _authRepositoryImpl.updateProfile(
        programme: programme, matricNo: matricNo, level: level);
    data.fold(
      (l) => _flushBarService.showFlushError(title: l),
      (r) => _flushBarService.showFlushSuccess(title: r),
    );
    locator<ScheduleProvider>().fetchUserDetails();
    _loading = false;
    notifyListeners();
  }

  Future<void> updateCourses() async {
    _loading = true;
    notifyListeners();
    final data =
        await _authRepositoryImpl.updateProfile(courses: selectedCourses);
    data.fold(
      (l) => _flushBarService.showFlushError(title: l),
      (r) => _flushBarService.showFlushSuccess(title: r),
    );
    locator<ScheduleProvider>().fetchUserDetails();
    _loading = false;
    notifyListeners();
  }

  Future<void> getCourses({required List<String> userCourses}) async {
    _loading = true;
    notifyListeners();
    final data = await _authRepositoryImpl.fetchSubjects();
    data.fold((l) => _flushBarService.showFlushError(title: l), (r) {
      _courses = r;
      _selectedCourses = userCourses;
    });
    _loading = false;
    notifyListeners();
  }

  void updateCourse(String course) {
    if (_selectedCourses.contains(course)) {
      _selectedCourses.remove(course);
    } else {
      _selectedCourses.add(course);
    }
    notifyListeners();
  }
}
