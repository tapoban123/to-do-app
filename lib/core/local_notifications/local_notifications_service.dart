import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:simple_todo_app/core/navigation_service/navigation_service.dart';
import 'package:simple_todo_app/pages/drawer_navigation.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

/// Contains each and every `functionality required to implement LocalNotifications`.
class LocalNotificationsService {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// Initialise LocalNotifications plugin.
  Future<void> initialiseLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings("pending_task_icon_white");

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse);

    tz.initializeTimeZones();
  }

  /// Navigates to an app page when notification is clicked.
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

  /// Implements all the necessary details of a specific notification.
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
      icon: "pending_task_icon_white",
      largeIcon: DrawableResourceAndroidBitmap("sticky_note"),
    );
  }

  /// Show `instant notifications` on Android.
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

  /// Show `scheduled notifications` on Android.
  Future<void> showScheduledNotification({
    required int notificationID,
    required String title,
    required String description,
    required DateTime scheduledDateTime,
  }) async {
    int notificationId = notificationID;

    // final timeZone = await FlutterTimezone.getLocalTimezone();
    // final timeZoneName = await tz.getLocation(timeZone);
    final scheduledDate = await tz.TZDateTime.from(scheduledDateTime, tz.local);
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

  /// `Cancels all notifications that are active`, meaning the notifications
  /// which have already been displayed but has not been cancelled yet.
  void cancelActiveNotifications() async {
    final activeNotifications =
        await flutterLocalNotificationsPlugin.getActiveNotifications();

    if (activeNotifications.isNotEmpty) {
      for (final notifications in activeNotifications) {
        cancelSpecificNotification(notifications.id!);
      }
    }
  }

  /// Cancels a specific notification by it's ID.
  void cancelSpecificNotification(int notificationID) async {
    await flutterLocalNotificationsPlugin.cancel(notificationID);
  }

  /// Cancels all scheduled notifications.
  void cancelAllNotification() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
