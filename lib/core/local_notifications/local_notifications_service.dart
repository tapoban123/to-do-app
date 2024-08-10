import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:simple_todo_app/core/navigation_service/navigation_service.dart';
import 'package:simple_todo_app/pages/drawer_navigation.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationsService {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialiseLocalNotifications() async {
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings("sticky_note");

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse);

    tz.initializeTimeZones();
  }

  void _onDidReceiveNotificationResponse(
    NotificationResponse notificationResponse,
  ) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('notification payload: $payload');
    }
    await Navigator.push(
      NavigationService.navigatorKey.currentState!.context,
      MaterialPageRoute<void>(builder: (context) => DrawerNavigation()),
    );
  }

  AndroidNotificationDetails _getAndroidNotificationDetails() {
    return AndroidNotificationDetails(
      'channel_id',
      'Channel_Name',
      channelDescription: 'Channel_Description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      color: Colors.purple,
      playSound: true,
      enableLights: true,
      audioAttributesUsage: AudioAttributesUsage.alarm,
      category: AndroidNotificationCategory.reminder,
      visibility: NotificationVisibility.public,
      indeterminate: true,
      sound: RawResourceAndroidNotificationSound('test_notification_sound'),
      icon: "sticky_note",
      largeIcon: DrawableResourceAndroidBitmap("sticky_note"),
    );
  }

  /// Show instant notifications on Android
  void showInstantNotificationAndroid(String title, String value) async {
    AndroidNotificationDetails androidNotificationDetails =
        _getAndroidNotificationDetails();

    int notificationId = 1;
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.show(
      notificationId,
      title,
      value,
      notificationDetails,
      payload: 'Not present',
    );
  }

  /// Show scheduled notifications on Android
  Future<void> showScheduledNotification({
    required int notificationID,
    required String title,
    required String description,
    required DateTime scheduledDateTime,
  }) async {
    // https://stackoverflow.com/questions/71031037/how-to-schedule-multiple-time-specific-local-notifications-in-flutter
    int notificationId = notificationID;

    final timeZone = await FlutterTimezone.getLocalTimezone();
    final timeZoneName = await tz.getLocation(timeZone);
    final scheduledDate = tz.TZDateTime.from(scheduledDateTime, timeZoneName);
    try {
      await flutterLocalNotificationsPlugin
          .zonedSchedule(
        notificationId,
        title,
        description,
        scheduledDate,
        NotificationDetails(
          android: _getAndroidNotificationDetails(),
        ),
        androidScheduleMode: AndroidScheduleMode.alarmClock,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      )
          .catchError((error) {
        throw ArgumentError(error.toString());
      });
    } catch (e) {
      rethrow;
    }
  }

  void cancelSpecificNotification(int notificationID) async {
    // flutterLocalNotificationsPlugin.getActiveNotifications()
    await flutterLocalNotificationsPlugin.cancel(notificationID);
  }

  void cancelAllNotification() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
