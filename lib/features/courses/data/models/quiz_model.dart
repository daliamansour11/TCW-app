
class QuizModel {

  QuizModel({
    required this.id,
    required this.title,
    required this.isCompleted,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      id: json['id'],
      title: json['title'],
      isCompleted: json['is_completed'],
    );
  }
  final int id;
  final String title;
  final bool isCompleted;

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'is_completed': isCompleted,
      };
}