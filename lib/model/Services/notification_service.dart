// ignore_for_file: deprecated_member_use

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:prayers/model/Services/settings_services.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  SettingsServices settingsServices = Get.find<SettingsServices>();
  FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('logo');

    var initializationSettings =
        InitializationSettings(android: androidInitializationSettings);

    await notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {},
    );
  }

  notificationDetails() {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        "channelId",
        "prayers",
        importance: Importance.max,
        priority: Priority.max,
      ),
    );
  }

  Future showNotificatoin({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async {
    return notificationsPlugin.show(
        id, title, body, await notificationDetails());
  }

  Future showScheduledNotificatoin(
      {int id = 0,
      String? title,
      String? body,
      String? payload,
      required DateTime scheduleTime}) async {
    return notificationsPlugin.zonedSchedule(id, title, body,
        tz.TZDateTime.from(scheduleTime, tz.local), await notificationDetails(),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }
}
