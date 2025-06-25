class PollOption {

  PollOption({
    required this.text,
    this.votes = 0,
    this.isSelected = false,
  });
  final String text;
  int votes;
  bool isSelected;
}
