import 'model.dart';

class Programme{
  final String? name;
  final num? id;
  final List<Lecture>? lectures;

  Programme({
    this.name, this.id,this.lectures
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'courses': lectures?.map((e) => e.toMap()).toList(),
    };
  }

  factory Programme.fromMap(Map<String, dynamic> map) {
    return Programme(
      name: map['name'] as String,
      id: map['id'] as num,
      lectures: (map['courses'] as List).map((e) => Lecture.fromMap(e)).toList(),
    );
  }
}
