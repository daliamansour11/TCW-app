class PollOption {
  final String text;
  int votes;
  bool isSelected;

  PollOption({
    required this.text,
    this.votes = 0,
    this.isSelected = false,
  });
}
