class LessonModel {
  int id;
  String title;
  String description;
  String lessonResource;
  dynamic videoResource;
  bool isCompleted;
  dynamic videoLinkPath;
  dynamic videoSourceType;
  final int? durationMinutes;

  LessonModel({
    required this.id,
    required this.title,
    required this.description,
    required this.lessonResource,
    required this.videoResource,
    required this.isCompleted,
    required this.videoLinkPath,
    required this.videoSourceType,
    this.durationMinutes,
  });

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    return LessonModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      lessonResource: json['lessonResource'] ?? '',
      videoResource: json['videoResource'],
      isCompleted: json['isCompleted'] ?? false,
      videoLinkPath: json['videoLinkPath'],
      videoSourceType: json['videoSourceType'],
      durationMinutes: json['durationMinutes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'lessonResource': lessonResource,
      'videoResource': videoResource,
      'isCompleted': isCompleted,
      'videoLinkPath': videoLinkPath,
      'videoSourceType': videoSourceType,
      'durationMinutes': durationMinutes,
    };
  }
}
