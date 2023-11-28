import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHandler {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  bool notificationsEnabled = true;

  Future _showNotification(RemoteMessage message) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channel id',
      'channel name',
      channelDescription: 'channel desc',
      importance: Importance.max,
      priority: Priority.high,
    );

    var platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Tempat Sampah Pintar',
      'Tempat sampah ${message.data['title']} kemungkinan ${message.data['condition']}',
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
  }

  Future initializeNotifications(String topic) async {
    var initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // Subscribe to the dynamic FCM topic
    await _firebaseMessaging.subscribeToTopic(topic);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("onMessage: $message");
      _showNotification(message);
    });

    FirebaseMessaging.onBackgroundMessage((message) async {
      print("onBackgroundMessage: $message");
      _showNotification(message);
    });
  }

  // Metode untuk menghentikan notifikasi
  void stopNotifications() {
    notificationsEnabled = false;
    flutterLocalNotificationsPlugin.cancelAll(); // Menghentikan semua notifikasi yang ditampilkan
  }
}
