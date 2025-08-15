
class LastViewedModel {

  LastViewedModel({
    required this.id,
    required this.userId,
    this.lastViewedCourse,
    this.lastViewedSection,
    this.lastViewedLesson,
    this.lastViewedQuiz,
    this.lastViewedAssignment,
    this.createdAt,
    this.updatedAt,
  });

  factory LastViewedModel.fromJson(Map<String, dynamic> json) {
    return LastViewedModel(
      id: json['id'],
      userId: json['user_id'],
      lastViewedCourse: json['last_viewed_course'],
      lastViewedSection: json['last_viewed_section'],
      lastViewedLesson: json['last_viewed_lesson'],
      lastViewedQuiz: json['last_viewed_quiz'],
      lastViewedAssignment: json['last_viewed_assignment'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
  final int id;
  final int userId;
  final int? lastViewedCourse;
  final int? lastViewedSection;
  final int? lastViewedLesson;
  final int? lastViewedQuiz;
  final int? lastViewedAssignment;
  final String? createdAt;
  final String? updatedAt;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'last_viewed_course': lastViewedCourse,
      'last_viewed_section': lastViewedSection,
      'last_viewed_lesson': lastViewedLesson,
      'last_viewed_quiz': lastViewedQuiz,
      'last_viewed_assignment': lastViewedAssignment,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
