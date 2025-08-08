class VideoItem {
  final String title;
  final String duration;
  final String thumbnailUrl;
  final bool isCompleted;
  final bool isTaskPending;

  VideoItem({
    required this.title,
    required this.duration,
    required this.thumbnailUrl,
    this.isCompleted = false,
    this.isTaskPending = false,
  });
}