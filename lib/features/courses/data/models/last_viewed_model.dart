class LastViewedModel {

  LastViewedModel({
    required this.lastViewedCourseId,
    required this.lastViewedSectionId,
    required this.lastViewedLessonId,
    this.lastViewedQuizId,
    this.lastViewedAssignment,
  });

  factory LastViewedModel.fromJson(Map<String, dynamic> json) {
    return LastViewedModel(
      lastViewedCourseId: json['last_viewed_course'],
      lastViewedSectionId: json['last_viewed_section'],
      lastViewedLessonId: json['last_viewed_lesson'],
      lastViewedQuizId: json['last_viewed_quiz'],
      lastViewedAssignment: json['last_viewed_assignment'],
    );
  }
  final int lastViewedCourseId;
  final int lastViewedSectionId;
  final int lastViewedLessonId;
  final int? lastViewedQuizId;
  final int? lastViewedAssignment;

  Map<String, dynamic> toJson() => {
        'last_viewed_course': lastViewedCourseId,
        'last_viewed_section': lastViewedSectionId,
        'last_viewed_lesson': lastViewedLessonId,
        'last_viewed_quiz': lastViewedQuizId,
        'last_viewed_assignment': lastViewedAssignment,
      };
}
