import 'package:flutter/material.dart';

class NotificationModel extends ChangeNotifier {
  final List<dynamic> _notifications = [];

  List<dynamic> get notifications => _notifications;

  void add(dynamic notification) {
    _notifications.insert(0, notification); // plus récent en haut
    notifyListeners();
  }

  void clear() {
    _notifications.clear();
    notifyListeners();
  }
}