import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tcw/features/reels/data/models/reel_history_model.dart';
import 'package:tcw/features/reels/data/models/reel_model.dart';

import '../../../../auth/data/datasources/auth_local_datasource_impl.dart';

int _safeInt(dynamic value) => value is int ? value : value != null ? int.tryParse(value.toString()) ?? 0 : 0;
Future<void> addReelToHistory(Datum reel) async {
  final currentUserId = await getCurrentUserId();
  if (currentUserId == null) return;

  final prefs = await SharedPreferences.getInstance();
  final key = 'reel_history_$currentUserId';
  final rawList = prefs.getStringList(key) ?? [];
  final history = rawList
      .map((e) => ReelHistoryModel.fromJson(jsonDecode(e)))
      .toList();

  // Remove duplicates
  history.removeWhere((item) => item.id == reel.id);

  final newItem = ReelHistoryModel(
    id: reel.id ?? 0,
    userId: currentUserId,
    videoPath: reel.videoPath ?? '',
    thumbnailPath: reel.thumbnailPath ?? '',
    caption: reel.caption ?? '',
    viewsCount: reel.viewsCount ?? 0,
    likesCount: reel.likesCount ?? 0,
    commentsCount: reel.commentsCount ?? 0,
    isActive: reel.isActive ?? 0,
    createdAt: reel.createdAt,
    updatedAt: reel.updatedAt,
    videoUrl: reel.videoUrl ?? '',
    thumbnailUrl: reel.thumbnailUrl ?? '',
    user: reel.user ?? User(id: 0, name: 'Unknown', image: '', imageUrl: ''),
    isLiked: reel.isLiked ?? false,
    watchedAt: DateTime.now(),
  );

  history.insert(0, newItem);

  // Limit history
  final limitedHistory = history.length > 50 ? history.sublist(0, 50) : history;

  final encoded = limitedHistory.map((e) => jsonEncode(e.toJson())).toList();
  await prefs.setStringList(key, encoded);
}

Future<List<ReelHistoryModel>> fetchUserReelHistory({int? limit}) async {
  final currentUserId = await getCurrentUserId();
  if (currentUserId == null) return [];

  final prefs = await SharedPreferences.getInstance();
  final key = 'reel_history_$currentUserId'; // User-specific key
  final rawList = prefs.getStringList(key) ?? [];

  final historyList = rawList
      .map((e) => ReelHistoryModel.fromJson(jsonDecode(e)))
      .toList();

  if (limit != null && limit > 0) {
    return historyList.take(limit).toList();
  }
  return historyList;
}

Future<void> removeReelFromHistory(int reelId) async {
  final currentUserId = await getCurrentUserId();
  if (currentUserId == null) return;

  final prefs = await SharedPreferences.getInstance();
  final key = 'reel_history_$currentUserId';
  final rawList = prefs.getStringList(key) ?? [];

  final updated = rawList
      .map((e) => ReelHistoryModel.fromJson(jsonDecode(e)))
      .where((item) => item.id != reelId)
      .map((e) => jsonEncode(e.toJson()))
      .toList();

  await prefs.setStringList(key, updated);
}

Future<int?> getCurrentUserId() async {
  final authLocal = AuthLocalDatasourceImpl();
  final user = await authLocal.getLoggedUser();
  return user?.id;
}