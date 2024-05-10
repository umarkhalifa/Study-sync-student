// Importing necessary packages and files
import 'package:alhikmah_schedule_student/config/services/shared_preference_service/shared_preference_service.dart';
import 'package:alhikmah_schedule_student/features/authentication/data/datasource/remote/auth_datasource.dart';
import 'package:alhikmah_schedule_student/features/authentication/domain/model/department.dart';
import 'package:alhikmah_schedule_student/features/authentication/domain/repositories/auth_repository.dart';
import 'package:alhikmah_schedule_student/locator.dart';
import 'package:alhikmah_schedule_student/utils/enum/app_firebase_exception_type.dart';
import 'package:dartz/dartz.dart';

// Implementing the AuthenticationRepository interface
class AuthRepositoryImpl implements AuthenticationRepository {
  // Creating an instance of AuthenticationDataSource
  final _authDataSource = locator<AuthenticationDataSource>();

  // Login function that returns a Future of Either<AppFirebaseExceptionType, bool>
  @override
  Future<Either<AppFirebaseExceptionType, bool>> login(
      {required String email, required String password}) async {
    // Calling the login function from AuthenticationDataSource
    final data = await _authDataSource.login(email: email, password: password);
    // Folding the result to handle errors and successes
    return data.fold((l) => Left(l), (r) {
      // If successful, setting the complete profile flag in SharedPreferenceProvider
      locator<SharedPreferenceProvider>().setCompleteProfile();
      return Right(r);
    });
  }

  // Register function that returns a Future of Either<AppFirebaseExceptionType, String>
  @override
  Future<Either<AppFirebaseExceptionType, String>> register(
      {required String email,
        required String password,
        required String name}) async {
    // Calling the register function from AuthenticationDataSource
    final data = await _authDataSource.register(
        email: email, password: password, name: name);
    // Folding the result to handle errors and successes
    return data.fold((l) => Left(l), (r) => Right(r));
  }

  // Reset password function that returns a Future of Either<AppFirebaseExceptionType, String>
  @override
  Future<Either<AppFirebaseExceptionType, String>> resetPassword(
      {required String email}) async {
    // Calling the forgotPassword function from AuthenticationDataSource
    final data = await _authDataSource.forgotPassword(email: email);
    // Folding the result to handle errors and successes
    return data.fold((l) => Left(l), (r) => Right(r));
  }

  // Fetch courses function that returns a Future of Either<String, List<Department>>
  @override
  Future<Either<String, List<Department>>> fetchCourses() async {
    // Calling the fetchProgrammes function from AuthenticationDataSource
    final data = await _authDataSource.fetchProgrammes();
    // Folding the result to handle errors and successes
    return data.fold((l) => Left(l), (r) {
      return Right(r);
    });
  }

  // Upload personal information function that returns a Future of Either<String, String>
  @override
  Future<Either<String, String>> uploadPersonalInformation(
      {required String matric,
        required int level,
        required String programme,
        required List<String> courses}) async {
    // Calling the uploadPersonalInformation function from AuthenticationDataSource
    final data = await _authDataSource.uploadPersonalInformation(
        matric: matric, level: level, programme: programme, courses: courses);
    // Folding the result to handle errors and successes
    return data.fold((l) => Left(l), (r) {
      // If successful, setting the complete profile flag in SharedPreferenceProvider
      locator<SharedPreferenceProvider>().setCompleteProfile();
      return Right(r);
    });
  }
}