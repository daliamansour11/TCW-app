class CourseModel {
  final int id;
  final String? thumb;
  final String? title;
  final String? subTitle;
  final List<String>? learningTopic;
  final String? requirements;
  final String? description;
  final int? totalLessons;
  final int? totalEnrolls;
  final int? completedLessons;
  final double? completedPercentage;
  final bool? isFree;
  final double? totalRating;
  final double? price;
  final bool? isDiscounted;
  final String? discountType;
  final double? discountedPrice;

  CourseModel({
    required this.id,
    this.thumb,
    this.title,
    this.subTitle,
    this.learningTopic,
    this.requirements,
    this.description,
    this.totalLessons,
    this.totalEnrolls,
    this.completedLessons,
    this.completedPercentage,
    this.isFree,
    this.totalRating,
    this.price,
    this.isDiscounted,
    this.discountType,
    this.discountedPrice,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'],
      thumb: json['thumb'],
      title: json['title'],
      subTitle: json['sub_title'],
      learningTopic: (json['learning_topic'] as List?)?.map((e) => e.toString()).toList(),
      requirements: json['requirements'],
      description: json['description'],
      totalLessons: json['totalLessons'],
      totalEnrolls: json['totalEnrolls'],
      completedLessons: json['completedLessons'],
      completedPercentage: (json['completedPercentage'] as num?)?.toDouble(),
      isFree: json['isFree'] == 1,
      totalRating: (json['totalRating'] as num?)?.toDouble(),
      price: (json['price'] as num?)?.toDouble(),
      isDiscounted: json['isDiscounted'] == 1,
      discountType: json['discountType'],
      discountedPrice: (json['discountedPrice'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'thumb': thumb,
        'title': title,
        'sub_title': subTitle,
        'learning_topic': learningTopic,
        'requirements': requirements,
        'description': description,
        'totalLessons': totalLessons,
        'totalEnrolls': totalEnrolls,
        'completedLessons': completedLessons,
        'completedPercentage': completedPercentage,
        'isFree': isFree == true ? 1 : 0,
        'totalRating': totalRating,
        'price': price,
        'isDiscounted': isDiscounted == true ? 1 : 0,
        'discountType': discountType,
        'discountedPrice': discountedPrice,
      };
}
