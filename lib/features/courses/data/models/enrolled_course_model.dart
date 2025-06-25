

class EnrolledCourseModel {

  EnrolledCourseModel({
    required this.id,
    required this.title,
    required this.description,
    required this.thumb,
    required this.progress,
    required this.status,
  });

  factory EnrolledCourseModel.fromJson(Map<String, dynamic> json) {
    return EnrolledCourseModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      thumb: json['thumb'],
      progress: json['progress'],
      status: json['status'],
    );
  }
  final int id;
  final String title;
  final String description;
  final String thumb;
  final int progress;
  final String status;

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'thumb': thumb,
        'progress': progress,
        'status': status,
      };
}