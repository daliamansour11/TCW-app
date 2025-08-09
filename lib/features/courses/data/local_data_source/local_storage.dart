import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


class ContinueWatchingManager {
  static const String _key = 'continue_watching_videos';

  Future<List<Map<String, dynamic>>> getContinueWatchingVideos() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> existing = prefs.getStringList(_key) ?? [];
    return existing.map((e) => Map<String, dynamic>.from(jsonDecode(e))).toList();
  }

  Future<void> saveOrUpdateVideoPosition({
    required String videoUrl,
    required int positionSeconds,
    int? lessonId,
    String? title,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> videos = await getContinueWatchingVideos();

    final index = videos.indexWhere((v) => v['videoUrl'] == videoUrl);
    final payload = {
      if (lessonId != null) 'lessonId': lessonId,
      if (title != null) 'title': title,
      'videoUrl': videoUrl,
      'position': positionSeconds,
      'updatedAt': DateTime.now().toIso8601String(),
    };

    if (index >= 0) {
      videos[index] = {...videos[index], ...payload};
    } else {
      videos.add(payload);
    }

    final encoded = videos.map((v) => jsonEncode(v)).toList();
    await prefs.setStringList(_key, encoded);
  }

  Future<void> removeVideo(String videoUrl) async {
    final prefs = await SharedPreferences.getInstance();
    final videos = await getContinueWatchingVideos();
    videos.removeWhere((v) => v['videoUrl'] == videoUrl);
    final encoded = videos.map((v) => jsonEncode(v)).toList();
    await prefs.setStringList(_key, encoded);
  }

  Future<int> getLastPosition(String videoUrl) async {
    final videos = await getContinueWatchingVideos();
    final item = videos.firstWhere((v) => v['videoUrl'] == videoUrl, orElse: () => {});
    return (item['position'] is int) ? item['position'] as int : 0;
  }
}