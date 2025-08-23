// import 'section_model.dart';
//
// class EnrolledCourseDetailsModel {
//   String status;
//   Data data;
//
//   EnrolledCourseDetailsModel({
//     required this.status,
//     required this.data,
//   });
//
//   factory EnrolledCourseDetailsModel.fromJson(Map<String, dynamic> json) {
//     return EnrolledCourseDetailsModel(
//       status: json['status'] ?? '',
//       data: Data.fromJson(json['data'] ?? {}),
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'status': status,
//       'data': data.toJson(),
//     };
//   }
// }
//
// class Data {
//   int id;
//   String thumb;
//   String title;
//   String subTitle;
//   List<String> learningTopic;
//   String requirements;
//   String description;
//   int completedLessons;
//   String completedPercentage;
//   int isFree;
//   dynamic totalRating;
//   int price;
//   int isDiscounted;
//   dynamic discountType;
//   dynamic discountedPrice;
//   List<SectionModel> sections;
//
//   Data({
//     required this.id,
//     required this.thumb,
//     required this.title,
//     required this.subTitle,
//     required this.learningTopic,
//     required this.requirements,
//     required this.description,
//     required this.completedLessons,
//     required this.completedPercentage,
//     required this.isFree,
//     required this.totalRating,
//     required this.price,
//     required this.isDiscounted,
//     required this.discountType,
//     required this.discountedPrice,
//     required this.sections,
//   });
//
//   factory Data.fromJson(Map<String, dynamic> json) {
//     return Data(
//       id: json['id'] ?? 0,
//       thumb: json['thumb'] ?? '',
//       title: json['title'] ?? '',
//       subTitle: json['subTitle'] ?? '',
//       learningTopic: List<String>.from(json['learningTopic'] ?? []),
//       requirements: json['requirements'] ?? '',
//       description: json['description'] ?? '',
//       completedLessons: json['completedLessons'] ?? 0,
//       completedPercentage: json['completedPercentage'] ?? '0%',
//       isFree: json['isFree'] ?? 0,
//       totalRating: json['totalRating'],
//       price: json['price'] ?? 0,
//       isDiscounted: json['isDiscounted'] ?? 0,
//       discountType: json['discountType'],
//       discountedPrice: json['discountedPrice'],
//       sections: (json['sections'] as List<dynamic>? ?? [])
//           .map((e) => SectionModel.fromJson(e))
//           .toList(),
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'thumb': thumb,
//       'title': title,
//       'subTitle': subTitle,
//       'learningTopic': learningTopic,
//       'requirements': requirements,
//       'description': description,
//       'completedLessons': completedLessons,
//       'completedPercentage': completedPercentage,
//       'isFree': isFree,
//       'totalRating': totalRating,
//       'price': price,
//       'isDiscounted': isDiscounted,
//       'discountType': discountType,
//       'discountedPrice': discountedPrice,
//       'sections': sections.map((e) => e.toJson()).toList(),
//     };
//   }
// }
