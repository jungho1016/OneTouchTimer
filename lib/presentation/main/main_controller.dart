import 'dart:async';

import 'package:get/get.dart';
import 'package:onetouchtimer/core/alarm/alarm.dart';
import 'package:onetouchtimer/presentation/main/main2_screen.dart';

class MainController extends GetxController {
  int eatTimeInSeconds = 0;
  int dietTimeInSeconds = 0;
  Timer? _timer;
  bool isTimerPaused = false;
  NotifyHelper notifyHelper = NotifyHelper();

  void startTimer(int hours) {
    if (_timer != null) {
      _timer!.cancel();
      update();
    }
    eatTimeInSeconds = hours * 3600;
    dietTimeInSeconds = hours * 3600;
    isTimerPaused = false;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!isTimerPaused && eatTimeInSeconds > 0) {
        eatTimeInSeconds--;
        update();
      } else if (eatTimeInSeconds <= 0) {
        timer.cancel();
        Get.to(() => Main2Screen(
              dietTimeInSeconds: dietTimeInSeconds,
            ));
        update();
      }
    });
  }

  void startTimer1(int seconds) {
    if (_timer != null) {
      _timer!.cancel();
      update();
    }
    eatTimeInSeconds = seconds;
    dietTimeInSeconds = seconds;
    isTimerPaused = false;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!isTimerPaused && eatTimeInSeconds > 0) {
        eatTimeInSeconds--;
        update();
      } else if (eatTimeInSeconds <= 0) {
        timer.cancel();
        Get.to(() => Main2Screen(
              dietTimeInSeconds: dietTimeInSeconds,
            ));
        notifyHelper.displayNotification(
            title: '원터치 알람', body: 'test body', payload: 'test');
        update();
      }
    });
  }

  void pauseOrResumeTimer() {
    isTimerPaused = !isTimerPaused;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
