class CourseModel {
  final int? id;
  final String? title;
  final String? subTitle;
  final String? thumbUrl;
  final int? price;
  final String? instructorName;
  final int? sectionsCount;
  final int? totalDurationMinutes;
  final int? availableSeats;
  final int? lessonsCount;
  final int? enrolledStudents;
  final bool? isFeatured;
  final dynamic discount;
  final bool? isSubscribed;
  final bool? isWishlisted;
  CourseModel({
    this.id,
    this.title,
    this.subTitle,
    this.thumbUrl,
    this.price,
    this.instructorName,
    this.sectionsCount,
    this.totalDurationMinutes,
    this.availableSeats,
    this.lessonsCount,
    this.enrolledStudents,
    this.isFeatured,
    this.discount,
    this.isSubscribed,
    this.isWishlisted,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'],
      title: json['title'],
      subTitle: json['sub_title'],
      thumbUrl: json['thumb_url'],
      price: json['price'],
      instructorName: json['instructor_name'],
      sectionsCount: json['sections_count'],
      totalDurationMinutes: json['total_duration_minutes'],
      availableSeats: json['available_seats'],
      lessonsCount: json['lessons_count'],
      enrolledStudents: json['enrolled_students'],
      isFeatured: json['is_featured'],
      discount: json['discount'],
      isSubscribed: json['is_subscribed'],
      isWishlisted: json['is_wishlisted'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'sub_title': subTitle,
      'thumb_url': thumbUrl,
      'price': price,
      'instructor_name': instructorName,
      'sections_count': sectionsCount,
      'total_duration_minutes': totalDurationMinutes,
      'available_seats': availableSeats,
      'lessons_count': lessonsCount,
      'enrolled_students': enrolledStudents,
      'is_featured': isFeatured,
      'discount': discount,
      'is_subscribed': isSubscribed,
      'is_wishlisted': isWishlisted,
    };
  }

  CourseModel copyWith({
    int? id,
    String? title,
    String? subTitle,
    String? thumbUrl,
    int? price,
    String? instructorName,
    int? sectionsCount,
    int? totalDurationMinutes,
    int? availableSeats,
    int? lessonsCount,
    int? enrolledStudents,
    bool? isFeatured,
    dynamic discount,
    bool? isSubscribed,
    bool? isWishlisted,
  }) {
    return CourseModel(
      id: id ?? this.id,
      title: title ?? this.title,
      subTitle: subTitle ?? this.subTitle,
      thumbUrl: thumbUrl ?? this.thumbUrl,
      price: price ?? this.price,
      instructorName: instructorName ?? this.instructorName,
      sectionsCount: sectionsCount ?? this.sectionsCount,
      totalDurationMinutes: totalDurationMinutes ?? this.totalDurationMinutes,
      availableSeats: availableSeats ?? this.availableSeats,
      lessonsCount: lessonsCount ?? this.lessonsCount,
      enrolledStudents: enrolledStudents ?? this.enrolledStudents,
      isFeatured: isFeatured ?? this.isFeatured,
      discount: discount ?? this.discount,
      isSubscribed: isSubscribed ?? this.isSubscribed,
      isWishlisted: isWishlisted ?? this.isWishlisted,
    );
  }
}
