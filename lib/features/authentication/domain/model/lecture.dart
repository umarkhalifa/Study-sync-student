import 'model.dart';

class Lecture {
  final String id;
  final String code;
  final String title;
  final String department;
  final List<LectureOccurrence> occurrences;
  final String? lecturer;
  final String? phoneNumber;

  Lecture({
    required this.id,
    required this.code,
    required this.title,
    required this.department,
    required this.occurrences,
    this.lecturer,
    this.phoneNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'code': code,
      'title': title,
      'department': department,
      'occurrences':occurrences.map((e) => e.toMap()).toList(),
      'lecturer': lecturer,
      'phoneNumber':phoneNumber
    };
  }

  factory Lecture.fromMap(Map<String, dynamic> map) {
    return Lecture(
      id: map['id'] as String,
      code: map['code'] as String,
      title: map['title'] as String,
      department: map['department'] as String,
      occurrences:(map['occurrences'] as List).map((e) => LectureOccurrence.fromMap(e)).toList(),
      lecturer: map['lecturer']??'',
      phoneNumber: map['phoneNumber']??''
    );
  }

  @override
  String toString() {
    return 'Lecture{id: $id, code: $code, title: $title, department: $department, occurrences: $occurrences}';
  }
}
