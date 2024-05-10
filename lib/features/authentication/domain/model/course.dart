class Course{
  final String? id;
  final String? department;
  final String? code;
  final String? title;

  Course({this.id, this.department, this.code, this.title});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'department': department,
      'code': code,
      'title': title,
    };
  }

  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
      id: map['id'] as String,
      department: map['department'] as String,
      code: map['code'] as String,
      title: map['title'] as String,
    );
  }
}
