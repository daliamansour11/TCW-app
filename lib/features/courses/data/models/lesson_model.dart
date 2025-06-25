import 'package:tcw/features/courses/data/models/resource_model.dart';

class LessonModel {
  LessonModel({
    required this.id,
    required this.title,
    required this.isCompleted,
    required this.resources,
  });

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    return LessonModel(
      id: json['id'],
      title: json['title'],
      isCompleted: json['is_completed'],
      resources: List<ResourceModel>.from(
          (json['resources'] as List).map((x) => ResourceModel.fromJson(x))),
    );
  }
  final int id;
  final String title;
  final bool isCompleted;
  final List<ResourceModel> resources;

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'is_completed': isCompleted,
        'resources': resources.map((x) => x.toJson()).toList(),
      };
}
