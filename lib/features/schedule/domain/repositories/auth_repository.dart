import 'package:alhikmah_schedule_student/soft.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepository{
  Future<Either<String, String>> fetchInformation();
}