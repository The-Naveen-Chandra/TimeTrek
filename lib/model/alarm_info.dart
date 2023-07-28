class AlarmInfo {
  DateTime alarmDateTime;
  String description;
  bool isActive;

  AlarmInfo({
    required this.alarmDateTime,
    required this.description,
    this.isActive = false,
  });
}
