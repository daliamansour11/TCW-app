class EnrolledCourseDetailsModel {
  final int id;
  final String thumb;
  final String title;
  final String subTitle;
  final List<String> learningTopic;
  final String requirements;
  final String description;
  final int completedLessons;
  final String completedPercentage;
  final int isFree;
  final dynamic totalRating;
  final double price;
  final int isDiscounted;
  final String? discountType;
  final double? discountedPrice;
  final List<Section> sections;
  final bool isWishlisted;
  final Instructor? instructor;

  EnrolledCourseDetailsModel({
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
    this.totalRating,
    required this.price,
    required this.isDiscounted,
    this.discountType,
    this.discountedPrice,
    required this.sections,
    this.isWishlisted = false,
    required this.instructor,


  });

  factory EnrolledCourseDetailsModel.fromJson(Map<String, dynamic> json) {
    return EnrolledCourseDetailsModel(
      id: json['id'],
      thumb: json['thumb'] ?? '',
      title: json['title'] ?? '',
      subTitle: json['sub_title'] ?? '',
      learningTopic: List<String>.from(json['learning_topic'] ?? []),
      requirements: json['requirements'] ?? '',
      description: json['description'] ?? '',
      completedLessons: json['completedLessons'] ?? 0,
      completedPercentage: json['completedPercentage'] ?? "0.00",
      isFree: json['isFree'] ?? 0,
      totalRating: json['totalRating'],
      price: (json['price'] is int) ? (json['price'] as int).toDouble() : (json['price'] ?? 0.0),
      isDiscounted: json['isDiscounted'] ?? 0,
      discountType: json['discountType'],

      discountedPrice: json['discountedPrice'] != null
          ? (json['discountedPrice'] is int)
          ? (json['discountedPrice'] as int).toDouble()
          : json['discountedPrice']
          : null,
      sections: (json['sections'] as List<dynamic>? ?? [])
          .map((e) => Section.fromJson(e))
          .toList(),
      isWishlisted: json['isWishlisted'] ?? false,
      instructor: json['instructor'] == null ? null : Instructor.fromJson(json['instructor']),

    );
  }

  Map<String, dynamic> toJson() {
    return {
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
      'sections': sections.map((e) => e.toJson()).toList(),
      'isWishlisted': isWishlisted,
      'instructor': instructor?.toJson(),


    };
  }

  EnrolledCourseDetailsModel copyWith({
    int? id,
    String? thumb,
    String? title,
    String? subTitle,
    List<String>? learningTopic,
    String? requirements,
    String? description,
    int? completedLessons,
    String? completedPercentage,
    int? isFree,
    dynamic totalRating,
    double? price,
    int? isDiscounted,
    String? discountType,
    double? discountedPrice,
    List<Section>? sections,
    bool? isWishlisted,
    final Instructor? instructor,


  }) {
    return EnrolledCourseDetailsModel(
      id: id ?? this.id,
      thumb: thumb ?? this.thumb,
      title: title ?? this.title,
      subTitle: subTitle ?? this.subTitle,
      learningTopic: learningTopic ?? this.learningTopic,
      requirements: requirements ?? this.requirements,
      description: description ?? this.description,
      completedLessons: completedLessons ?? this.completedLessons,
      completedPercentage: completedPercentage ?? this.completedPercentage,
      isFree: isFree ?? this.isFree,
      totalRating: totalRating ?? this.totalRating,
      price: price ?? this.price,
      isDiscounted: isDiscounted ?? this.isDiscounted,
      discountType: discountType ?? this.discountType,
      discountedPrice: discountedPrice ?? this.discountedPrice,
      sections: sections ?? this.sections,
      isWishlisted: isWishlisted ?? this.isWishlisted,
      instructor: instructor ?? this.instructor,

    );
  }
}

class Section {
  final int id;
  final String title;
  final String description;
  final List<Lesson> lessons;
  final List<Quiz> quizs;

  Section({
    required this.id,
    required this.title,
    required this.description,
    required this.lessons,
    required this.quizs,
  });

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      id: json['id'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      lessons: (json['lessons'] as List<dynamic>? ?? [])
          .map((e) => Lesson.fromJson(e))
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

  Section copyWith({
    int? id,
    String? title,
    String? description,
    List<Lesson>? lessons,
    List<Quiz>? quizs,
  }) {
    return Section(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      lessons: lessons ?? this.lessons,
      quizs: quizs ?? this.quizs,
    );
  }
}

class Lesson {
  final int id;
  final String title;
  final String description;
  final String? lessonResource;
  final String? videoResource;
  final bool isCompleted;
  final String? videoLinkPath;
  final String? videoSourceType;

  Lesson({
    required this.id,
    required this.title,
    required this.description,
    this.lessonResource,
    this.videoResource,
    required this.isCompleted,
    this.videoLinkPath,
    this.videoSourceType,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      lessonResource: json['lesson_resource'],
      videoResource: json['video_resource'],
      isCompleted: json['is_completed'] ?? false,
      videoLinkPath: json['video_link_path'],
      videoSourceType: json['video_source_type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'lesson_resource': lessonResource,
      'video_resource': videoResource,
      'is_completed': isCompleted,
      'video_link_path': videoLinkPath,
      'video_source_type': videoSourceType,
    };
  }

  Lesson copyWith({
    int? id,
    String? title,
    String? description,
    String? lessonResource,
    String? videoResource,
    bool? isCompleted,
    String? videoLinkPath,
    String? videoSourceType,
  }) {
    return Lesson(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      lessonResource: lessonResource ?? this.lessonResource,
      videoResource: videoResource ?? this.videoResource,
      isCompleted: isCompleted ?? this.isCompleted,
      videoLinkPath: videoLinkPath ?? this.videoLinkPath,
      videoSourceType: videoSourceType ?? this.videoSourceType,
    );
  }
}

class Quiz {
  final int id;
  final int sectionId;
  final String title;
  final String description;
  final int marks;

  Quiz({
    required this.id,
    required this.sectionId,
    required this.title,
    required this.description,
    required this.marks,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json['id'],
      sectionId: json['section_id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      marks: json['marks'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'section_id': sectionId,
      'title': title,
      'description': description,
      'marks': marks,
    };
  }

  Quiz copyWith({
    int? id,
    int? sectionId,
    String? title,
    String? description,
    int? marks,
  }) {
    return Quiz(
      id: id ?? this.id,
      sectionId: sectionId ?? this.sectionId,
      title: title ?? this.title,
      description: description ?? this.description,
      marks: marks ?? this.marks,
    );
  }
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
