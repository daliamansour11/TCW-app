import 'package:tcw/features/courses/data/models/section_model.dart';
import 'package:tcw/features/courses/data/models/intro_model.dart';

class CourseModel {

  CourseModel({
    required this.id,
    required this.title,
    required this.subTitle,
    this.categoryId,
    this.subCategoryId,
    this.instructorId,
    required this.learningTopic,
    required this.requirements,
    required this.description,
    required this.price,
    required this.status,
    required this.isFeatured,
    required this.greetings,
    required this.congratulationMessage,
    required this.thumb,
    this.createdAt,
    this.updatedAt,
    this.sections,
    this.moreCourses,
    this.courseIntroVideo,
    this.videoSourceType,
    this.videoLinkPath,
    this.intro,
    this.completedLessons,
    this.completedPercentage,
    this.isFree,
    this.totalRating,
    this.isDiscounted,
    this.discountType,
    this.discountedPrice,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'],
      title: json['title'] ?? '',
      subTitle: json['sub_title'] ?? '',
      categoryId: json['category_id'],
      subCategoryId: json['sub_category_id'],
      instructorId: json['instructor_id'],
      learningTopic: List<String>.from(json['learning_topic'] ?? []),
      requirements: json['requirements'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] as num).toDouble(),
      status: json['status'] == true,
      isFeatured: json['is_featured'] == 1,
      greetings: json['greetings'] ?? '',
      congratulationMessage: json['congratulation_message'] ?? '',
      thumb: json['thumb'] ?? '',
      createdAt: DateTime.tryParse(json['created_at'] ?? ''),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? ''),
      sections: (json['sections'] as List?)?.map((e) => SectionModel.fromJson(e)).toList(),
      moreCourses: (json['more_course'] as List?)?.map((e) => CourseModel.fromJson(e)).toList(),
      courseIntroVideo: json['course_intro_video'],
      videoSourceType: json['video_source_type'],
      videoLinkPath: json['video_link_path'],
      intro: json['intro'] != null ? IntroModel.fromJson(json['intro']) : null,
      completedLessons: json['completedLessons'],
      completedPercentage: (json['completedPercentage'] as num?)?.toDouble(),
      isFree: json['isFree'] == 1,
      totalRating: (json['totalRating'] as num?)?.toDouble(),
      isDiscounted: json['isDiscounted'] == 1,
      discountType: json['discountType'],
      discountedPrice: (json['discountedPrice'] as num?)?.toDouble(),
    );
  }
  final int id;
  final String title;
  final String subTitle;
  final int? categoryId;
  final int? subCategoryId;
  final int? instructorId;
  final List<String> learningTopic;
  final String requirements;
  final String description;
  final double price;
  final bool status;
  final bool isFeatured;
  final String greetings;
  final String congratulationMessage;
  final String thumb;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<SectionModel>? sections;
  final List<CourseModel>? moreCourses;
  final String? courseIntroVideo;
  final String? videoSourceType;
  final String? videoLinkPath;
  final IntroModel? intro;

  // Extra fields for enrolled view
  final int? completedLessons;
  final double? completedPercentage;
  final bool? isFree;
  final double? totalRating;
  final bool? isDiscounted;
  final String? discountType;
  final double? discountedPrice;


  static List<CourseModel> get test => List.generate(5, (index) => CourseModel(
    id: index,
    title: 'Course $index',
    subTitle: 'Sub Title $index',
    learningTopic: ['Learning Topic $index'],
    requirements: 'Requirements $index',
    description: 'Description $index',
    price: 100,
    status: true,
    isFeatured: true,
    greetings: 'Greetings $index',
    congratulationMessage: 'Congratulation Message $index',
    thumb: 'https://img.freepik.com/free-vector/matrix-style-binary-code-digital-falling-numbers-blue-background_1017-37387.jpg',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    sections: [],
    moreCourses: [],
    courseIntroVideo: 'https://via.placeholder.com/150',
    videoSourceType: 'https://via.placeholder.com/150',
    videoLinkPath: 'https://via.placeholder.com/150',
  ));
}
