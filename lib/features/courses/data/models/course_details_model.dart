import '../../../courses/data/models/lesson_model.dart';

class CourseDetailsModel {

  factory CourseDetailsModel.fromJson(Map<String, dynamic> json) {
    return CourseDetailsModel(
      status: json['status'] ??'',
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }
  CourseDetailsModel({
    required this.status,
    required this.data,
  });

  final String? status;
  final Data? data;

  Map<String, dynamic> toJson() => {
    'status': status,
    'data': data?.toJson(),
  };
}

class Data {

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      title: json['title'],
      subTitle: json['sub_title'],
      description: json['description'],
      requirements: json['requirements'],
      learningTopics: List<String>.from(json['learning_topics'] ?? []),
      price: json['price'],
      thumbUrl: json['thumb_url'],
      instructor: json['instructor'] == null ? null : Instructor.fromJson(json['instructor']),
      isSubscribed: json['is_subscribed'],
      availableSeats: json['available_seats'],
      sectionsCount: json['sections_count'],
      totalDurationMinutes: json['total_duration_minutes'],
      introVideo: json['intro_video'] == null ? null : IntroVideo.fromJson(json['intro_video']),
      sections: (json['sections'] as List?)?.map((x) => Section.fromJson(x)).toList() ?? [],
      moreCourses: (json['more_courses'] as List?)?.map((x) => MoreCourse.fromJson(x)).toList() ?? [],
    );
  }
  Data({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.description,
    required this.requirements,
    required this.learningTopics,
    required this.price,
    required this.thumbUrl,
    required this.instructor,
    required this.isSubscribed,
    required this.availableSeats,
    required this.sectionsCount,
    required this.totalDurationMinutes,
    required this.introVideo,
    required this.sections,
    required this.moreCourses,
  });
  final int? id;
  final String? title;
  final String? subTitle;
  final String? description;
  final String? requirements;
  final List<String> learningTopics;
  final int? price;
  final String? thumbUrl;
  final Instructor? instructor;
  final bool? isSubscribed;
  final int? availableSeats;
  final int? sectionsCount;
  final int? totalDurationMinutes;
  final IntroVideo? introVideo;
  final List<Section> sections;
  final List<MoreCourse> moreCourses;

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'sub_title': subTitle,
    'description': description,
    'requirements': requirements,
    'learning_topics': learningTopics,
    'price': price,
    'thumb_url': thumbUrl,
    'instructor': instructor?.toJson(),
    'is_subscribed': isSubscribed,
    'available_seats': availableSeats,
    'sections_count': sectionsCount,
    'total_duration_minutes': totalDurationMinutes,
    'intro_video': introVideo?.toJson(),
    'sections': sections.map((x) => x.toJson()).toList(),
    'more_courses': moreCourses.map((x) => x.toJson()).toList(),
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

class Section {

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      id: json['id'],
      topic: json['topic'],
      description: json['description'],
      durationMinutes: json['duration_minutes'],
      totalLessons: json['totalLessons'],
      lessons: (json['lessons'] as List?)?.map((x) => LessonModel.fromJson(x)).toList(),
    );
  }
  Section({
    this.id,
    this.topic,
    this.description,
    this.durationMinutes,
    this.lessons,
    this.totalLessons,
  });

  final int? id;
  final String? topic;
  final String? description;
  final int? durationMinutes;
  final List<LessonModel>? lessons;
  final int? totalLessons;

  Map<String, dynamic> toJson() => {
    'id': id,
    'topic': topic,
    'description': description,
    'duration_minutes': durationMinutes,
    'totalLessons': totalLessons,
    'lessons': lessons?.map((x) => x.toJson()).toList(),
  };
}
class MoreCourse {

  factory MoreCourse.fromJson(Map<String, dynamic> json) {
    return MoreCourse(
      id: json['id'],
      thumb: json['thumb'],
      title: json['title'],
      subTitle: json['sub_title'],
      learningTopic: List<String>.from(json['learning_topic'] ?? []),
      requirements: json['requirements'],
      description: json['description'],
      completedLessons: json['completedLessons'],
      completedPercentage: json['completedPercentage'],
      isFree: json['isFree'],
      totalRating: json['totalRating'],
      price: json['price'],
      isDiscounted: json['isDiscounted'],
      discountType: json['discountType'],
      discountedPrice: json['discountedPrice'],
    );
  }
  MoreCourse({
    required this.id,
    required this.thumb,
    required this.title,
    required this.subTitle,
    required this.learningTopic,
    required this.requirements,
    required this.description,
    required this.completedLessons,
    required this.completedPercentage,
    required this.isFree,
    required this.totalRating,
    required this.price,
    required this.isDiscounted,
    required this.discountType,
    required this.discountedPrice,
  });

  final int? id;
  final String? thumb;
  final String? title;
  final String? subTitle;
  final List<String> learningTopic;
  final String? requirements;
  final String? description;
  final int? completedLessons;
  final dynamic completedPercentage;
  final int? isFree;
  final dynamic totalRating;
  final int? price;
  final int? isDiscounted;
  final dynamic discountType;
  final dynamic discountedPrice;

  Map<String, dynamic> toJson() => {
    'id': id,
    'thumb': thumb,
    'title': title,
    'sub_title': subTitle,
    'learning_topic': learningTopic,
    'requirements': requirements,
    'description': description,
    'completedLessons': completedLessons,
    'completedPercentage': completedPercentage,
    'isFree': isFree,
    'totalRating': totalRating,
    'price': price,
    'isDiscounted': isDiscounted,
    'discountType': discountType,
    'discountedPrice': discountedPrice,
  };
}
