class ProgramModel {

  factory ProgramModel.fromJson(Map<String, dynamic> json){
    return ProgramModel(
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
    );
  }
    ProgramModel({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.thumbUrl,
    required this.price,
    required this.instructorName,
    required this.sectionsCount,
    required this.totalDurationMinutes,
    required this.availableSeats,
    required this.lessonsCount,
    required this.enrolledStudents,
    required this.isFeatured,
    required this.discount,
    required this.isSubscribed,
  });



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

}



