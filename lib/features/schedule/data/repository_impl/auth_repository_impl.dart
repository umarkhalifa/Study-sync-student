import 'package:alhikmah_schedule_student/config/services/shared_preference_service/shared_preference_service.dart';
import 'package:alhikmah_schedule_student/features/authentication/data/datasource/remote/auth_datasource.dart';
import 'package:alhikmah_schedule_student/features/authentication/domain/repositories/auth_repository.dart';
import 'package:alhikmah_schedule_student/locator.dart';
import 'package:alhikmah_schedule_student/soft.dart';
import 'package:alhikmah_schedule_student/utils/enum/app_firebase_exception_type.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl implements AuthenticationRepository {
  final _authDataSource = locator<AuthenticationDataSource>();

  @override
  Future<Either<AppFirebaseExceptionType, bool>> login(
      {required String email, required String password}) async {
    locator<SharedPreferenceProvider>().setCompleteProfile();
    final data = await _authDataSource.login(email: email, password: password);
    return data.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<AppFirebaseExceptionType, String>> register(
      {required String email, required String password,required String name}) async{
    final data = await _authDataSource.register(email: email, password: password,name: name);
    return data.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<AppFirebaseExceptionType, String>> resetPassword(
      {required String email}) async{
    final data = await _authDataSource.forgotPassword(email: email);
    return data.fold((l) => Left(l), (r) => Right(r));

  }

  @override
  Future<Either<String, List<Programme>>> fetchCourses()async {
    final data = await _authDataSource.fetchProgrammes();
    return data.fold((l) => Left(l), (r) {
      locator<SharedPreferenceProvider>().setCompleteProfile();
return Right(r);
    } );
  }

  @override
  Future<Either<String, String>> uploadPersonalInformation({required String matric, required int level, required String programme, required List<Course> courses})async {
    final data = await _authDataSource.uploadPersonalInformation(matric: matric, level: level, programme: programme, courses: courses);
    return data.fold((l) => Left(l), (r) {
    locator<SharedPreferenceProvider>().setCompleteProfile();
    return Right(r);
    } );
  }
}
