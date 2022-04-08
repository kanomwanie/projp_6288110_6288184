import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'server.dart';
import 'dart:math';
Random random = new Random();

Future<void> createWaterReminderNotification(
    times A,String name) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: random.nextInt(100000000),
      channelKey: 'scheduled_channel',
      title:
      'Time to take you medicine!',
      body: 'It\'s time to take $name. The more you follow doctor instruction. The faster you will feel better!',
      notificationLayout: NotificationLayout.Default,
    ),
    schedule: NotificationCalendar(
      hour: A.h,
      minute: A.m,
      second: 0,
      millisecond: 0,
    ),
  );
}

Future<void> createWaterReminderNotification2(
    times A,String name,String frinedname) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: random.nextInt(100000000),
      channelKey: 'scheduled_channel',
      title:
      'Friend Medicine Notification',
      body: 'Tell your friend $frinedname to take $name! The more they follow doctor instruction. The faster they will feel better!',
      notificationLayout: NotificationLayout.Default,
    ),
    schedule: NotificationCalendar(
      hour: A.h,
      minute: A.m,
      second: 0,
      millisecond: 0,
    ),
  );
}

Future<void> cancelScheduledNotifications() async {
  await AwesomeNotifications().cancelAllSchedules();
}