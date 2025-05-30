import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzData;

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    tzData.initializeTimeZones();
    
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
        
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
        
    await notificationsPlugin.initialize(initializationSettings);
  }

  Future<void> scheduleBiweeklyReminder() async {
    await notificationsPlugin.cancelAll();
    
    const androidDetails = AndroidNotificationDetails(
      'clip_clop_channel',
      'Clip Clop Reminders',
      channelDescription: 'Reminders to trim your nails',
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
      enableVibration: true,
    );
    
    final notificationDetails = NotificationDetails(android: androidDetails);
    
    // Schedule for every 14 days at 10 AM
    await notificationsPlugin.zonedSchedule(
      0,
      'Clip Clop Reminder!',
      'Time for your biweekly nail trim!',
      _nextBiweeklyDate(),
      notificationDetails,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
    );
  }

  tz.TZDateTime _nextBiweeklyDate() {
    final now = tz.TZDateTime.now(tz.local);
    var nextDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, 10);
    
    // If today is reminder day and time hasn't passed yet
    if (now.day % 14 == 0 && now.hour < 10) {
      return nextDate;
    }
    
    // Otherwise find next reminder day
    int daysToAdd = 14 - (now.day % 14);
    nextDate = nextDate.add(Duration(days: daysToAdd));
    return nextDate;
  }
}