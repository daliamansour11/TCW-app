import 'package:tcw/features/courses/data/models/lesson_model.dart';

import 'course_detail_model.dart';

class SectionModel {
  SectionModel({
    required this.id,
    required this.topic,
    required this.description,
    required this.courseId,
    this.createdAt,
    this.updatedAt,
    required this.lessons,
    this.durationMinutes,
    required this.totalLessons,
    required this.instructor,
  });

  factory SectionModel.fromJson(Map<String, dynamic> json) {
    return SectionModel(
      id: json['id'],
      topic: json['topic'] ?? '',
      description: json['description'] ?? '',
      courseId: json['course_id'],
      createdAt: DateTime.tryParse(json['created_at'] ?? ''),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? ''),
      lessons: List<Lesson>.from(
          (json['lessons'] as List).map((x) => Lesson.fromJson(x))),
      durationMinutes: json['duration_minutes'],
      totalLessons: json['totalLessons'],
      instructor: json['instructor'] == null ? null : Instructor.fromJson(json['instructor']),

    );
  }
  final int id;
  final List<Lesson> lessons;
  final String topic;
  final String description;
  final int courseId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? durationMinutes;
  final int? totalLessons;
  final Instructor? instructor;

  Map<String, dynamic> toJson() => {
        'id': id,
        'lessons': lessons.map((x) => x.toJson()).toList(),
      };
}
class Instructor {

  factory Instructor.fromJson(Map<String, dynamic> json) {
    print('Instructor JSON: $json'); // DEBUG
    return Instructor(
      id: json['id'],
      name: json['name'],
    );
  }
  Instructor({
    required this.id,
    required this.name,
  });

  final int? id;
  final String? name;

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
  };
}
