import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:onetouchtimer/presentation/main/second_screen.dart';
import 'package:timezone/standalone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotifyHelper {
  static final StreamController<String> _streamController =
      StreamController<String>();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initializeNotification() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('drawable/ic_stat_name');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );
  }

  void displayNotification(
      {required String title,
      required String body,
      required String payload}) async {
    print("Displaying notification: $title - $body");
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'your channel id', 'alarm channel',
        channelDescription: 'test',
        importance: Importance.max,
        priority: Priority.high,
        icon: 'drawable/ic_stat_name');
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: payload,
    );
  }

  void scheduleNotification() async {
    tz.initializeTimeZones();
    final korea = tz.getLocation('Asia/Seoul');

    final scheduledTime =
        tz.TZDateTime.now(korea).add(const Duration(seconds: 10));

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      '일정된 제목',
      '이것은 예약된 알림입니다.',
      scheduledTime,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'your channel id',
          'your channel name',
        ),
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future selectNotification(String payload) async {
    if (payload != null) {
      print('notification payload: $payload');
    } else {
      print("Notification Done");
    }
    Get.to(() => SecondScreen(
          payload: payload,
        ));
  }

  Future onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title!),
        content: Text(body!),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('Ok'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SecondScreen(
                    payload: payload,
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    //! Payload(전송 데이터)를 Stream에 추가합니다.
    final String payload = notificationResponse.payload ?? "";
    if (notificationResponse.payload != null ||
        notificationResponse.payload!.isNotEmpty) {
      print('FOREGROUND PAYLOAD: $payload');
      _streamController.add(payload);
    }
  }

  //! Background 상태(앱이 닫힌 상태에서 받은 경우)
  void onBackgroundNotificationResponse() async {
    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    //! 앱이 Notification을 통해서 열린 경우라면 Payload(전송 데이터)를 Stream에 추가합니다.
    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      String payload =
          notificationAppLaunchDetails!.notificationResponse?.payload ?? "";
      print("BACKGROUND PAYLOAD: $payload");
      _streamController.add(payload);
    }
  }
}
