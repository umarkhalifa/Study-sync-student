import 'package:alhikmah_schedule_student/config/services/flushbar_service/flushbar_service.dart';
import 'package:alhikmah_schedule_student/config/services/push_notification_service/local_push_notifications.dart';
import 'package:alhikmah_schedule_student/config/services/shared_preference_service/shared_preference_service.dart';
import 'package:alhikmah_schedule_student/features/authentication/data/datasource/remote/auth_datasource.dart';
import 'package:alhikmah_schedule_student/features/authentication/data/repository_impl/auth_repository_impl.dart';
import 'package:alhikmah_schedule_student/features/authentication/presentation/providers/auth_provider.dart';
import 'package:alhikmah_schedule_student/features/profile/presentation/provider/profile_provider.dart';
import 'package:alhikmah_schedule_student/features/schedule/data/datasource/remote/schedule_datasource.dart';
import 'package:alhikmah_schedule_student/features/schedule/data/repository_impl/schedule_repository_impl.dart';
import 'package:alhikmah_schedule_student/features/schedule/presentation/providers/schedule_provider.dart';
import 'package:get_it/get_it.dart';

/// This is our global ServiceLocator, used to ensure each service class
/// class has only one instance
GetIt locator = GetIt.instance;

void setupLocator(){
  locator.registerLazySingleton(() => ScheduleProvider());
  locator.registerLazySingleton(() => AuthenticationDataSource());
  locator.registerLazySingleton(() => AuthRepositoryImpl());
  locator.registerLazySingleton(() => ScheduleDataSource());
  locator.registerLazySingleton(() => ScheduleRepositoryImpl());
  locator.registerLazySingleton(() => AuthProvider());
  locator.registerLazySingleton(() => ProfileProvider());
  locator.registerLazySingleton(() => FlushBarService());
  locator.registerLazySingleton(() => SharedPreferenceProvider());
  locator.registerLazySingleton(() => LocalNotificationService());
}