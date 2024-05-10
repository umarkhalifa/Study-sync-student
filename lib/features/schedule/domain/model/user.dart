class UserProfile{
  final String? programme;
  final num? level;
  final String? matricNo;
  final List<String>? courses;

  UserProfile({this.programme, this.level, this.matricNo, this.courses});

  Map<String, dynamic> toMap() {
    return {
      'programme': programme,
      'level': level,
      'matricNo': matricNo,
      'courses': courses,
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      programme: map['Programme'] as String,
      level: map['Level'] as num,
      matricNo: map['Matric No'] as String,
      courses: (map['Courses'] as List).map((e) => e.toString()).toList(),
    );
  }
}