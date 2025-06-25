class Task {
  Task({
    required this.title,
    required this.subtitle,
    required this.status,
    required this.date,
    required this.isCompleted,
    this.fileSize,
    this.details,
  });
  String get createdBy => 'Ahmed Mohammed';
  String get createdAt => 'Sun, 9 March 2025';
  String get description =>
      'Build an interactive UI using React with state management and components.';
  List<String> get requirements => [
        'Component Structure: Create reusable components.',
        'State Management: Implement Redux for state management.',
        'Testing: Write unit tests for components.',
        'Documentation: Add comments and documentation.',
        'Code Review: Review code for best practices.',
        'Performance Optimization: Optimize code for performance.',
        'Code Review: Review code for best practices.',
      ];
  final String? details ;
  final String title;
  final String subtitle;
  final String status;
  final String date;
  final bool isCompleted;
  final String? fileSize;
}
