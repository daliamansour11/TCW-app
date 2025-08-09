import '../../../programmes/data/models/program_detail_model.dart';

class LessonModel {
  factory LessonModel.fromJson(Map<String, dynamic> json) {
    return LessonModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      durationMinutes: json['duration_minutes'],
      courseId: json['course_id'],
      sectionId: json['section_id'],
      video: json['video'] != null ? IntroVideo.fromJson(json['video']) : null,
    );
  }

  LessonModel({
    this.id,
    this.title,
    this.description,
    this.durationMinutes,
    this.courseId,
    this.sectionId,
    this.video,
  });

  final int? id;
  final String? title;
  final String? description;
  final int? durationMinutes;
  final int? courseId;
  final int? sectionId;
  final IntroVideo? video;

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'duration_minutes': durationMinutes,
    'course_id': courseId,
    'section_id': sectionId,
    'video': video?.toJson(),
  };
}
