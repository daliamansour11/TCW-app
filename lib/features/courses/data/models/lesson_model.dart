class LessonModel {
  final String title;
  final String author;
  final DateTime date;
  final String videoUrl;
  final String lessonTitle;
  final String lessonDescription;
  final String documentType;
  final String taskTitle;
  final String taskDescription;
  final String taskDeadline;

  LessonModel({
    required this.title,
    required this.author,
    required this.date,
    required this.videoUrl,
    required this.lessonTitle,
    required this.lessonDescription,
    required this.documentType,
    required this.taskTitle,
    required this.taskDescription,
    required this.taskDeadline,
  });
}
