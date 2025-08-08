// reel_history.dart
class HistoryService {
  static final HistoryService _instance = HistoryService._internal();
  factory HistoryService() => _instance;
  HistoryService._internal();

  final List<int> _watchedReels = [];

  void addToHistory(int reelId) {
    if (!_watchedReels.contains(reelId)) {
      _watchedReels.add(reelId);
    }
  }

  bool isWatched(int reelId) => _watchedReels.contains(reelId);
}