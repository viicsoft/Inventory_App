import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future notification() async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'viccSoft', 'crisptv',
      importance: Importance.max, priority: Priority.high);
  var iOSPlatformChannelSpecifics = const IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
    0,
    'Inventory',
    'More than one equipment is bad',
    platformChannelSpecifics,
  );
}
