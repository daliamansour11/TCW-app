import 'package:tcw/features/courses/data/models/lesson_model.dart';

class SectionModel {
  SectionModel({
    required this.id,
    required this.topic,
    required this.description,
    required this.courseId,
    this.createdAt,
    this.updatedAt,
    required this.lessons,
  });

  factory SectionModel.fromJson(Map<String, dynamic> json) {
    return SectionModel(
      id: json['id'],
      topic: json['topic'] ?? '',
      description: json['description'] ?? '',
      courseId: json['course_id'],
      createdAt: DateTime.tryParse(json['created_at'] ?? ''),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? ''),
      lessons: List<LessonModel>.from(
          (json['lessons'] as List).map((x) => LessonModel.fromJson(x))),
    );
  }
  final int id;
  final List<LessonModel> lessons;
  final String topic;
  final String description;
  final int courseId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  Map<String, dynamic> toJson() => {
        'id': id,
        'lessons': lessons.map((x) => x.toJson()).toList(),
      };
}
