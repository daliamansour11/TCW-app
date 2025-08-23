
import 'lesson_model.dart';
import 'quiz_model.dart';

class SectionModel {
  int id;
  String title;
  String description;
  List<LessonModel> lessons;
  List<Quiz> quizs;

  SectionModel({
    required this.id,
    required this.title,
    required this.description,
    required this.lessons,
    required this.quizs,
  });

  factory SectionModel.fromJson(Map<String, dynamic> json) {
    return SectionModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      lessons: (json['lessons'] as List<dynamic>? ?? [])
          .map((e) => LessonModel.fromJson(e))
          .toList(),
      quizs: (json['quizs'] as List<dynamic>? ?? [])
          .map((e) => Quiz.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'lessons': lessons.map((e) => e.toJson()).toList(),
      'quizs': quizs.map((e) => e.toJson()).toList(),
    };
  }
}
