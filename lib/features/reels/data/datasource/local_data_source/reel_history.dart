import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tcw/features/reels/data/models/reel_history_model.dart';
import 'package:tcw/features/reels/data/models/reel_model.dart';

int _safeInt(dynamic value) => value is int ? value : value != null ? int.tryParse(value.toString()) ?? 0 : 0;

Future<void> addReelToHistory(Datum reel) async {
  final prefs = await SharedPreferences.getInstance();
  final rawList = prefs.getStringList('reel_history') ?? [];

  final history = rawList
      .map((e) => ReelHistoryModel.fromJson(jsonDecode(e)))
      .toList();

  // Remove existing entries with same ID
  history.removeWhere((item) => item.id == reel.id);

  final newItem = ReelHistoryModel(
    id: reel.id ?? 0,
    userId: _safeInt(reel.userId),
    videoPath: reel.videoPath ?? '',
    thumbnailPath: reel.thumbnailPath ?? '',
    caption: reel.caption ?? '',
    viewsCount: _safeInt(reel.viewsCount),
    likesCount: _safeInt(reel.likesCount),
    commentsCount: _safeInt(reel.commentsCount),
    isActive: _safeInt(reel.isActive),
    createdAt: reel.createdAt,
    updatedAt: reel.updatedAt,
    videoUrl: reel.videoUrl ?? '',
    thumbnailUrl: reel.thumbnailUrl ?? '',
    user: reel.user ?? User(id: 0, name: 'Unknown', image: '', imageUrl: ''),
    isLiked: reel.isLiked ?? false,
    watchedAt: DateTime.now(),
  );

  history.insert(0, newItem);

  // Limit history to 50 items
  final limitedHistory = history.length > 50
      ? history.sublist(0, 50)
      : history;

  // Save back to shared preferences
  final encoded = limitedHistory.map((e) => jsonEncode(e.toJson())).toList();
  await prefs.setStringList('reel_history', encoded);
}

Future<List<ReelHistoryModel>> fetchLimitedReelsFromHistory({int limit = 5}) async {
  final prefs = await SharedPreferences.getInstance();
  final rawList = prefs.getStringList('reel_history') ?? [];

  return rawList
      .map((e) => ReelHistoryModel.fromJson(jsonDecode(e)))
      .take(limit)
      .toList();
}