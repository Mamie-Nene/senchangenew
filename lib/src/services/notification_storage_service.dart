import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class NotificationStorageService {
  static const String _key = "stored_notifications";

  static Future<void> saveNotification(Map<String, dynamic> notif) async {
    final prefs = await SharedPreferences.getInstance();
    final existing = prefs.getStringList(_key) ?? [];

    existing.add(jsonEncode(notif));
    await prefs.setStringList(_key, existing);
  }

  static Future<List<Map<String, dynamic>>> getNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getStringList(_key) ?? [];

    return stored.map((s) => jsonDecode(s) as Map<String, dynamic>).toList();
  }

  static Future<void> clearNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }

}