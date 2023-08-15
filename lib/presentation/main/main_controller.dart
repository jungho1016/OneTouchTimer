import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:onetouchtimer/core/alarm/alarm.dart';
import 'package:onetouchtimer/presentation/diet/diet_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainController extends GetxController with WidgetsBindingObserver {
  int eatTimeInSeconds = 0;
  int dietTimeInSeconds = 0;
  Timer? _timer;
  bool isTimerPaused = false;
  NotifyHelper notifyHelper = NotifyHelper();
  Rx<StreamSubscription>? _backgroundAlarmSubscription;

  @override
  void onInit() {
    super.onInit();
    _setupBackgroundAlarm();
    WidgetsBinding.instance?.addObserver(this);
    restoreSavedData();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    _backgroundAlarmSubscription?.value.cancel();
    _timer?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (_timer == null || !_timer!.isActive) {
        _startTimer();
      }
    } else if (state == AppLifecycleState.paused) {
      _timer?.cancel();
    }
  }

  void _backgroundAlarmCallback() {
    if (!isTimerPaused && eatTimeInSeconds > 0) {
      eatTimeInSeconds--;
      update();
    } else if (eatTimeInSeconds <= 0) {
      Get.to(() => DietScreen(
            dietTimeInSeconds: dietTimeInSeconds,
          ));
      notifyHelper.displayNotification(
          title: '원터치 알람', body: '식사 시간이 완료되었습니다.', payload: 'test');
      update();
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!isTimerPaused) {
        if (eatTimeInSeconds > 0) {
          eatTimeInSeconds--;
          saveDataOnExit(); // 데이터 저장
        } else {
          timer.cancel();
          Get.to(() => DietScreen(
                dietTimeInSeconds: dietTimeInSeconds,
              ));
          notifyHelper.displayNotification(
              title: '원터치 알람', body: '식사 시간이 완료되었습니다.', payload: 'test');
          update();
        }
      }
    });
  }

  void _setupBackgroundAlarm() async {
    await AndroidAlarmManager.periodic(
      const Duration(seconds: 10), // 1분마다 실행 (원하는 주기로 설정)
      1, // 아무 정수값
      _backgroundAlarmCallback,
      wakeup: true,
      rescheduleOnReboot: true,
    );
  }

  void startTimer(int eatHours, int dietHours) {
    if (_timer != null) {
      _timer!.cancel();
      update();
    }
    eatTimeInSeconds = eatHours * 3600;
    dietTimeInSeconds = dietHours * 3600;
    isTimerPaused = false;
    saveDataOnExit(); // 데이터 저장
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!isTimerPaused) {
        if (eatTimeInSeconds > 0) {
          eatTimeInSeconds--;
          saveDataOnExit();
          update(); // 데이터 저장
        } else {
          timer.cancel();
          Get.to(() => DietScreen(
                dietTimeInSeconds: dietTimeInSeconds,
              ));
          notifyHelper.displayNotification(
              title: '원터치 알람', body: '식사 시간이 완료되었습니다.', payload: 'test');
          update();
        }
      }
    });
  }

  void startTimer1(int eatHours, int dietHours) {
    if (_timer != null) {
      _timer!.cancel();
      update();
    }
    eatTimeInSeconds = eatHours;
    dietTimeInSeconds = dietHours;
    isTimerPaused = false;
    saveDataOnExit(); // 데이터 저장
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!isTimerPaused) {
        if (eatTimeInSeconds > 0) {
          eatTimeInSeconds--;
          saveDataOnExit(); //
          update(); // 데이터 저장
        } else {
          timer.cancel();
          Get.to(() => DietScreen(
                dietTimeInSeconds: dietTimeInSeconds,
              ));
          notifyHelper.displayNotification(
              title: '원터치 알람', body: '식사 시간이 완료되었습니다.', payload: 'test');
          update();
        }
      }
    });
  }

  void pauseOrResumeTimer() {
    isTimerPaused = !isTimerPaused;
    if (!isTimerPaused) {
      startTimer1(eatTimeInSeconds, dietTimeInSeconds);
      update();
    } else {
      _timer?.cancel();
    }
    update();
  }

  Future<void> restoreSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    dietTimeInSeconds = prefs.getInt('dietTimeInSeconds') ?? 0;
    int savedDietTimeInSeconds = prefs.getInt('eatTimeInSeconds') ?? 0;
    int saveTime =
        prefs.getInt('saveTime') ?? DateTime.now().millisecondsSinceEpoch;
    int nowInSeconds =
        ((DateTime.now().millisecondsSinceEpoch - saveTime) / 1000).round();
    eatTimeInSeconds = savedDietTimeInSeconds - nowInSeconds;

    isTimerPaused = prefs.getBool('isTimerPaused') ?? false;

    if (!isTimerPaused && eatTimeInSeconds > 0) {
      startTimer1(eatTimeInSeconds, dietTimeInSeconds);
      update(); // 타이머 시작
    }
  }

  Future<void> saveDataOnExit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt('eatTimeInSeconds', eatTimeInSeconds);
    prefs.setInt('dietTimeInSeconds', dietTimeInSeconds);
    prefs.setBool('isTimerPaused', isTimerPaused);
    prefs.setInt('saveTime', DateTime.now().millisecondsSinceEpoch);
  }

  Future<void> clearSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    eatTimeInSeconds = 0;
    dietTimeInSeconds = 0;
    isTimerPaused = false;
    update();
  }
}
