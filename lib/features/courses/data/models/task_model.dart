
class Task {
  final String title;
  final String subtitle;
  final String status;
  final String date;
  final bool isCompleted;
  final String? fileSize;

  Task({
    required this.title,
    required this.subtitle,
    required this.status,
    required this.date,
    required this.isCompleted,
    this.fileSize,
  });
}
