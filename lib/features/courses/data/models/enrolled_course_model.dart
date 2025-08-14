
class EnrolledCourseModel {

  EnrolledCourseModel({
    required this.title,
    required this.instructor,
    required this.date,
    required this.thumb,
    required this.id,


    required this.watchedLessons,
    required this.totalLessons,
    this.isEnrolled = true,
  });

  factory EnrolledCourseModel.fromJson(Map<String, dynamic> json) {
    return EnrolledCourseModel(
      title: json['title'] ?? '',
      instructor: json['instructor'] ?? '',
      date: DateTime.parse(json['date']),
      watchedLessons: json['watchedLessons'] ?? 0,
      id: json['id'] ?? 0,
      totalLessons: json['totalLessons'] ?? 0,
      isEnrolled: json['isEnrolled'] ?? true,
      thumb: json['thumb'],
    );
  }
  final String title;
  final String instructor;
  final DateTime date;
  final int watchedLessons;
  final int totalLessons;
  final bool isEnrolled;
    final String thumb;
  final int id;


  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'instructor': instructor,
      'date': date.toIso8601String(),
      'watchedLessons': watchedLessons,
      'totalLessons': totalLessons,
      'isEnrolled': isEnrolled,
      'thumb': thumb,
    };
  }
}
