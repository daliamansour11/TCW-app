class Event {
  final String date;
  final String time;
  final String title;
  final String description;
  final String coachName;
  final String coachRole;
  final bool isAlertSet;

  Event({
    required this.date,
    required this.time,
    required this.title,
    required this.description,
    required this.coachName,
    required this.coachRole,
    required this.isAlertSet,
  });
}
