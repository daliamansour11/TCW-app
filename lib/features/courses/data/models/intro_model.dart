class IntroModel {

  IntroModel({
    required this.id,
    required this.courseId,
    this.assignmentId,
    this.lessonId,
    this.quizId,
    required this.fileName,
    required this.resourseType,
    required this.videoSourceType,
    required this.path,
    this.videoLinkPath,
    required this.mimeType,
    this.createdAt,
    this.updatedAt,
    required this.isVideo,
  });

  factory IntroModel.fromJson(Map<String, dynamic> json) {
    return IntroModel(
      id: json['id'],
      courseId: json['course_id'],
      assignmentId: json['assignment_id'],
      lessonId: json['lesson_id'],
      quizId: json['quiz_id'],
      fileName: json['file_name'] ?? '',
      resourseType: json['resourse_type'] ?? '',
      videoSourceType: json['video_source_type'] ?? '',
      path: json['path'] ?? '',
      videoLinkPath: json['video_link_path'],
      mimeType: json['mime_type'] ?? '',
      createdAt: DateTime.tryParse(json['created_at'] ?? ''),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? ''),
      isVideo: json['is_video'] == true,
    );
  }
  final int id;
  final int courseId;
  final int? assignmentId;
  final int? lessonId;
  final int? quizId;
  final String fileName;
  final String resourseType;
  final String videoSourceType;
  final String path;
  final String? videoLinkPath;
  final String mimeType;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool isVideo;
}
