class LectureOccurrence {
  final int day;
  final int start;
  final int end;
  final String venue; // Venue for each occurrence

  LectureOccurrence({
    required this.day,
    required this.start,
    required this.end,
    required this.venue,
  });

  Map<String, dynamic> toMap() {
    return {
      'day': day,
      'start': start,
      'end': end,
      'venue': venue,
    };
  }

  factory LectureOccurrence.fromMap(Map<String, dynamic> map) {
    return LectureOccurrence(
      day: map['day'] as int,
      start: map['start'] as int,
      end: map['end'] as int,
      venue: map['venue'] as String,
    );
  }

  @override
  String toString() {
    return 'LectureOccurrence{day: $day, start: $start, end: $end, venue: $venue}';
  }
}
