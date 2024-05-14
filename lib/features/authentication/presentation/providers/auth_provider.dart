import 'dart:developer';

import 'package:alhikmah_schedule_student/config/services/flushbar_service/flushbar_service.dart';
import 'package:alhikmah_schedule_student/config/services/shared_preference_service/shared_preference_service.dart';
import 'package:alhikmah_schedule_student/features/authentication/data/repository_impl/auth_repository_impl.dart';
import 'package:alhikmah_schedule_student/features/authentication/domain/model/department.dart';
import 'package:alhikmah_schedule_student/features/authentication/domain/model/model.dart';
import 'package:alhikmah_schedule_student/locator.dart';
import 'package:alhikmah_schedule_student/main.dart';
import 'package:alhikmah_schedule_student/utils/enum/app_state.dart';
import 'package:alhikmah_schedule_student/utils/extensions/auth_exception.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  //<---------------------- SETTERS ---------------------->
  final authRepo = locator<AuthRepositoryImpl>();
  final flushBarService = locator<FlushBarService>();
  final _sharedPreferenceService = locator<SharedPreferenceProvider>();

  List<Department> _programmes = [];
  Department? _programme;
  final List<Course> _selectedCourses = [];
  int _selectedLevel = 100;
  AppState _appState = AppState.idle;
  AuthState _authState = AuthState.register;

  //<---------------------- GETTERS ---------------------->
  List<Department> get programmes => _programmes;

  Department? get programme => _programme;

  List<Course> get selectedCourses => _selectedCourses;

  int get selectedLevel => _selectedLevel;

  AppState get appState => _appState;

  AuthState get authState => _authState;

  //<---------------------- METHODS ---------------------->

  /// Update App's Authentication state i.e Change authentication screen from
  /// login to register and vice versa
  void updateAuthState(AuthState state) {
    _authState = state;
    notifyListeners();
  }

  /// Login
  Future<void> login({required String email, required String password}) async {
    try {
      // Set the app state to loading.
      _appState = AppState.loading;
      notifyListeners();

      // Attempt login.
      final data = await authRepo.login(email: email, password: password);

      // Handle the result.
      data.fold(
            (error) {
          // Show error message to the user.
          flushBarService.showFlushError(title: error.toText());
        },
            (result) {
          if (result) {
            // Navigate to home page upon successful login.
            navigatorKey.currentState!.pushNamed('/home');
          } else {
            // Navigate to personal information page if users profile does
            // not exist.
            navigatorKey.currentState!.pushNamed('/personalInformation');
          }
        },
      );
    } catch (error) {
      // Handle unexpected errors.
      log('An unexpected error occurred: $error');
      // You may want to show a generic error message to the user here.
    } finally {
      // Reset the app state to idle, regardless of success or failure.
      _appState = AppState.idle;
      notifyListeners();
    }
  }

  /// Register
  Future<void> register({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      // Set the app state to loading.
      _appState = AppState.loading;
      notifyListeners();

      // Attempt registration.
      final data = await authRepo.register(
        email: email,
        password: password,
        name: name,
      );

      // Handle the result.
      data.fold(
            (error) {
          // Show error message to the user.
          flushBarService.showFlushError(title: error.toText());
        },
            (result) {
          // Navigate to personal information page upon successful registration.
          navigatorKey.currentState!.pushNamed('/personalInformation');
        },
      );
    } catch (error) {
      // Handle unexpected errors.
      log('An unexpected error occurred: $error');
      // You may want to show a generic error message to the user here.
    } finally {
      // Reset the app state to idle, regardless of success or failure.
      _appState = AppState.idle;
      notifyListeners();
    }
  }

  void updateOnBoardingState(){
    _sharedPreferenceService.setOnBoarding();

  }



  /// Fetch courses
  Future<void> fetchCourses() async {
    try {
      // Set the app state to loading.
      _appState = AppState.completeLoading;
      notifyListeners();

      // Fetch courses.
      final data = await authRepo.fetchCourses();

      // Handle the result.
      data.fold(
            (error) {
          // Show error message to the user.
          flushBarService.showFlushError(title: error);
        },
            (courses) {
          // Update courses on success.
          _programmes = courses;
          // Notify listeners after updating courses.
          notifyListeners();
        },
      );
    } catch (error) {
      // Handle unexpected errors.
      log('An unexpected error occurred: $error');
      // You may want to show a generic error message to the user here.
    } finally {
      // Reset the app state to idle, regardless of success or failure.
      _appState = AppState.idle;
      notifyListeners();
    }
  }

  // Send reset password Email
  Future<void> forgotPassword({required String email})async{
    try {
      // Set the app state to loading.
      _appState = AppState.loading;
      notifyListeners();

      // Attempt registration.
      final data = await authRepo.resetPassword(email: email);

      // Handle the result.
      data.fold(
            (error) {
          // Show error message to the user.
          flushBarService.showFlushError(title: error.toText());
        },
            (result) {
              flushBarService.showFlushSuccess(title: result);
              // Navigate to personal information page upon successful registration.
          navigatorKey.currentState!.pop();
        },
      );
    } catch (error) {
      // Handle unexpected errors.
      log('An unexpected error occurred: $error');
      // You may want to show a generic error message to the user here.
    } finally {
      // Reset the app state to idle, regardless of success or failure.
      _appState = AppState.idle;
      notifyListeners();
    }

  }

  // Update the users selected programme
  void selectProgramme(Department newProgramme) {
    _programme = newProgramme;
    notifyListeners();
  }

  // Update selected day
  void updateSelectedLevel(int level) {
    _selectedLevel = level;
    notifyListeners();
  }

  /// Select and deselect courses
  void updateSelectedCourse(Course course) {
    if (selectedCourses.contains(course)) {
      // If the course is already selected, remove it.
      selectedCourses.remove(course);
    } else {
      // If the course is not selected, add it.
      selectedCourses.add(course);
    }
    // Notify listeners after the list is updated.
    notifyListeners();
  }


  Future<void> uploadPersonalInformation({required String matric}) async {
    try {
      // Set the app state to loading.
      _appState = AppState.loading;
      notifyListeners();

      // Perform the upload operation.
      final data = await authRepo.uploadPersonalInformation(
        matric: matric,
        level: _selectedLevel,
        programme: programme?.name ?? '',
        courses: selectedCourses.map((e) => e.id!).toList(),
      );

      // Handle the result.
      data.fold(
            (error) {
          // Show error message to the user.
          flushBarService.showFlushError(title: error);
        },
            (result) {
          // Navigate to the home screen upon successful upload.
          Navigator.pushReplacementNamed(navigatorKey.currentContext!, '/home');
        },
      );
    } catch (error) {
      // Handle unexpected errors.
      log('An unexpected error occurred: $error');
      // You may want to show a generic error message to the user here.
    } finally {
      // Reset the app state to idle, regardless of success or failure.
      _appState = AppState.idle;
      notifyListeners();
    }
  }
}

enum AuthState { register, login }
