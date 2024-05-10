import 'model.dart';

class Department{
  final String? name;
  final num? id;
  final List<Course>? courses;

  Department({this.name, this.id,this.courses});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'courses': courses,
    };
  }

  factory Department.fromMap(Map<String, dynamic> map) {
    return Department(
      name: map['name'] as String,
      id: map['id'] as num,
      courses: (map['courses'] as List).map((e) => Course.fromMap(e)).toList(),
    );
  }}