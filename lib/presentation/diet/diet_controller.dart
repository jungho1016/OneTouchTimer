import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onetouchtimer/core/component/circle_component.dart';
import 'package:onetouchtimer/core/component/elevatedbutton_component.dart';
import 'package:onetouchtimer/core/component/text_component.dart';
import 'dart:async';

import 'package:onetouchtimer/presentation/main/second_screen.dart';

class DietController extends GetxController {
  late Timer _timer;
  int dietTimeInSeconds = 0;
  bool isTimerPaused = false;

  @override
  void onInit() {
    super.onInit();
    _timer = Timer.periodic(const Duration(seconds: 1), _timerCallback);
  }

  void _timerCallback(Timer timer) {
    if (!isTimerPaused && dietTimeInSeconds > 0) {
      dietTimeInSeconds--;
    } else if (dietTimeInSeconds <= 0) {
      timer.cancel();
      // Perform actions when the timer reaches 0
      // For example, navigate back or display a notification
    }
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }

  void startTimer(int seconds) {
    if (_timer.isActive) {
      _timer.cancel();
      update();
    }
    dietTimeInSeconds = seconds;
    isTimerPaused = false;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!isTimerPaused && dietTimeInSeconds > 0) {
        dietTimeInSeconds--;
      } else if (dietTimeInSeconds <= 0) {
        timer.cancel();
        Get.back();
        notifyHelper.displayNotification(
            title: '원터치 알람', body: '단식 시간이 완료되었습니다.', payload: 'test');
      }
      update();
    });
  }

  void pauseOrResumeTimer() {
    isTimerPaused = !isTimerPaused;
    if (!isTimerPaused) {
      startTimer(dietTimeInSeconds);
      update();
    } else {
      _timer.cancel();
    }
    update();
  }
}
