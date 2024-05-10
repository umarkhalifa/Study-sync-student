extension ToTime on int{
  String toTime() {
    if (this < 12) {
      return "${toString().padLeft(2,'0')}:00am";
    }
    return '$this:00pm';
  }
}