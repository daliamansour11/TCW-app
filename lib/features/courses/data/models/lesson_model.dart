// import 'package:tcw/features/courses/data/models/resource_model.dart';
//
// class LessonModel {
//   LessonModel({
//     required this.id,
//     required this.title,
//     required this.isCompleted,
//     required this.resources,
//   });
//   factory LessonModel.fromJson(Map<String, dynamic> json) {
//     return LessonModel(
//       id: json['id'],
//       title: json['title'],
//       isCompleted: json['is_completed'],
//       resources: List<ResourceModel>.from(
//           (json['resources'] as List).map((x) => ResourceModel.fromJson(x))),
//     );
//   }
//   final int id;
//   final String title;
//   final bool isCompleted;
//   final List<ResourceModel> resources;
//
//   Map<String, dynamic> toJson() => {
//         'id': id,
//         'title': title,
//         'is_completed': isCompleted,
//         'resources': resources.map((x) => x.toJson()).toList(),
//       };
// }


class LessonModel {

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    return LessonModel(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        durationMinutes: json['duration_minutes'],
        video: IntroVideo.fromJson(json['video']));
  }
  LessonModel({
    this.id,
    this.title,
    this.description,
    this.durationMinutes,
    this.video,
  });

  final int? id;
  final String? title;
  final String? description;
  final int? durationMinutes;
  final IntroVideo? video;

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'title': title,
        'description': description,
        'duration_minutes': durationMinutes,
        'video': video
      };
}
enum LessonStatus {
  pending,
  completed,
  inProgress,
  locked,
}

class IntroVideo {

  factory IntroVideo.fromJson(Map<String, dynamic> json) {
    return IntroVideo(
      url: json['url'],
      sourceType: json['source_type'],
      linkPath: json['link_path'],
    );
  }
  IntroVideo({
    required this.url,
    required this.sourceType,
    required this.linkPath,
  });

  final String? url;
  final String? sourceType;
  final dynamic linkPath;

  Map<String, dynamic> toJson() => {
    'url': url,
    'source_type': sourceType,
    'link_path': linkPath,
  };
}


