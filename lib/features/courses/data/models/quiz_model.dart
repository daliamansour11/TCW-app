
class Quiz {
  int id;
  int sectionId;
  String title;
  String description;
  int marks;

  Quiz({
    required this.id,
    required this.sectionId,
    required this.title,
    required this.description,
    required this.marks,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json['id'] ?? 0,
      sectionId: json['sectionId'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      marks: json['marks'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sectionId': sectionId,
      'title': title,
      'description': description,
      'marks': marks,
    };
  }
}
