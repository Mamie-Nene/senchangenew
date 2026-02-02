import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {

  //  ID auto-incrémenté
  static int _notificationId = 0;

  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  /// Initialise le plugin de notifications
  static Future<void> init() async {
    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('@mipmap/launcher_icon');

    final DarwinInitializationSettings iosInitSettings =
    DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

     InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosInitSettings, // <-- This is required for iOS
    );

    await _notificationsPlugin.initialize(initSettings);
  }

  /// Affiche une notification simple
  static Future<void> show(String title, String body) async {
    const AndroidNotificationDetails androidDetails =
    AndroidNotificationDetails(
      'default_channel_id',
      'Notifications',
      channelDescription: 'Canal de notification par défaut',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    await _notificationsPlugin.show(
      _notificationId++,
      title,
      body,
      notificationDetails,
    );
  }

  static void resetNotificationId() {
    _notificationId = 0;
  }
}
// // Configuration Android
// const AndroidInitializationSettings initializationSettingsAndroid =
//     AndroidInitializationSettings('@mipmap/launcher_icon');
// // const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('notification_icon'); // ton icône ici

// final InitializationSettings initializationSettings = InitializationSettings(
//   android: initializationSettingsAndroid,
// );

// await flutterLocalNotificationsPlugin.initialize(initializationSettings);
