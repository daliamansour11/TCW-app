import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../programmes/data/models/program_detail_model.dart' hide Instructor;
import '../models/lesson_model.dart';
import '../models/section_model.dart';

class ContinueWatchingManager {
  static const String _storageKey = 'continueWatching';
  static final ValueNotifier<List<Map<String, dynamic>>> notifier =
  ValueNotifier<List<Map<String, dynamic>>>([]);

  /// Save or update lesson progress (most recent first)
  static Future<void> addOrUpdateLesson({
    required SectionModel section,
    required LessonModel lesson,
    int? resumePositionMs,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now().millisecondsSinceEpoch;

    final data = {
      'courseId': lesson.courseId,
      'sectionId': section.id,
      'sectionTopic': section.topic,
      'sectionDuration': section.durationMinutes,
      'instructorName': section.instructor?.name,
      'lessonId': lesson.id,
      'lessonTitle': lesson.title,
      'lessonDuration': lesson.durationMinutes,
      'videoUrl': lesson.video?.linkPath,
      'lastWatched': now,
      'resumePositionMs': resumePositionMs ?? 0,
    };

    // Read current list
    final list = prefs.getStringList(_storageKey) ?? [];

    // Remove any existing entry for this lesson
    list.removeWhere((e) => jsonDecode(e)['lessonId'] == lesson.id);

    // Add to front
    list.insert(0, jsonEncode(data));

    // Keep max 20
    final limitedList = list.take(20).toList();

    // Save to SharedPreferences
    await prefs.setStringList(_storageKey, limitedList);

    // Update notifier instantly
    final decodedList = limitedList
        .map((e) => jsonDecode(e) as Map<String, dynamic>)
        .toList();
    notifier.value = decodedList;
  }

  /// Get fully built LessonModel + SectionModel for the UI
  Future<List<Map<String, dynamic>>> getContinueWatchingModels() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_storageKey) ?? [];

    final sorted = list
        .map((e) => jsonDecode(e) as Map<String, dynamic>)
        .toList()
      ..sort((a, b) => (b['lastWatched'] ?? 0).compareTo(a['lastWatched'] ?? 0));

    return sorted.map((item) {
      final lesson = LessonModel(
        id: item['lessonId'],
        courseId: item['courseId'],
        sectionId: item['sectionId'],
        title: item['lessonTitle'],
        durationMinutes: item['lessonDuration'],
        video: IntroVideo(
          linkPath: item['videoUrl'],
          url: '',
          sourceType: '',
        ),
        //TODO// must exist in LessonModel

        resumePositionMs: item['resumePositionMs'] ?? 0,
      );

      final section = SectionModel(
        id: item['sectionId'],
        topic: item['sectionTopic'] ?? '',
        durationMinutes: item['sectionDuration'],
        instructor: Instructor(
          name: item['name'] ?? 'Coach',
          id: 0,
        ),

        lessons: [lesson],
        description: '',
        totalLessons: 0, // default int
        courseId: 0, // default int
      );

      return {
        'lesson': lesson,
        'section': section,
      };
    }).toList();
  }
}
