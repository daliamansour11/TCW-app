class Task {
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      status: json['status'] ?? '',
      isCompleted: json['is_completed'] ?? false,
      fileSize: json['file_size'],
      details: json['details'],
      description: json['description'], createdBy:json['createdBy']?? '',
      createdAt:json['createdAt']?? '',
      date:json['date']?? '',
      requirements:json['requirements']?? '',
    );
  }
  Task({
    required this.title,
    required this.subtitle,
    required this.status,
    required this.createdBy,
    required this.createdAt,
    required this.isCompleted,
    this.fileSize,
    this.details,
    this.description,
    this.date,
    this.requirements,
  });

  final String title;
  final String subtitle;
  final String status;
  final String createdBy;
  final String createdAt;
  final bool isCompleted;
  final String? fileSize;
  final String? description;
  final String? requirements;
  final String? details;
  final DateTime? date;
}
