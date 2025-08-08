import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String _readNotificationIdsKey = 'readNotificationIds';

  Future<void> markNotificationAsReadLocally(int notificationId) async {
    final prefs = await SharedPreferences.getInstance();
    final readIds = prefs.getStringList(_readNotificationIdsKey) ?? [];

    if (!readIds.contains(notificationId.toString())) {
      readIds.add(notificationId.toString());
      await prefs.setStringList(_readNotificationIdsKey, readIds);
    }
  }

  Future<List<int>> getReadNotificationIds() async {
    final prefs = await SharedPreferences.getInstance();
    final readIds = prefs.getStringList(_readNotificationIdsKey) ?? [];
    return readIds.map(int.parse).toList();
  }

  Future<void> clearReadNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_readNotificationIdsKey);
  }
}
