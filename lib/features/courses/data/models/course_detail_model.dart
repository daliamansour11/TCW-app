import 'package:tcw/features/courses/data/models/section_model.dart';

class CourseDetailModel {
  CourseDetailModel({
    required this.id,
    required this.title,
    required this.sections,
  });

  factory CourseDetailModel.fromJson(Map<String, dynamic> json) {
    return CourseDetailModel(
      id: json['id'],
      title: json['title'],
      sections: List<SectionModel>.from(
          (json['sections']as List).map((x) => SectionModel.fromJson(x))),
    );
  }
  final int id;
  final String title;
  final List<SectionModel> sections;

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'sections': sections.map((x) => x.toJson()).toList(),
      };
}
