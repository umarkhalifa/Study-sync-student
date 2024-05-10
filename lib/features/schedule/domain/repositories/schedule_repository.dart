import 'package:alhikmah_schedule_student/features/authentication/domain/model/model.dart';
import 'package:alhikmah_schedule_student/features/schedule/domain/model/user.dart';
import 'package:dartz/dartz.dart';

abstract class ScheduleRepository{
  Future<Either<String, UserProfile>> fetchUserProfile();
  Future<Either<String, List<Lecture>>> fetchLectures({required String course, required List<String> courses});
  Future<List<Lecture>> fetchTimeTale({required int day,required List<Lecture> lectures});
}