import 'package:flutter/material.dart';
import 'package:onetouchtimer/core/component/circle_component.dart';
import 'package:onetouchtimer/core/component/elevatedbutton_component.dart';
import 'package:onetouchtimer/core/component/text_component.dart';
import 'dart:async';

class Main2Screen extends StatefulWidget {
  final int dietTimeInSeconds;

  const Main2Screen({Key? key, required this.dietTimeInSeconds})
      : super(key: key);

  @override
  _Main2ScreenState createState() => _Main2ScreenState();
}

class _Main2ScreenState extends State<Main2Screen> {
  int dietTimeInSeconds = 0;
  Timer? _timer;
  bool isTimerPaused = false;

  void startTimer(int seconds) {
    if (_timer != null) {
      _timer!.cancel();
    }
    setState(() {
      dietTimeInSeconds = seconds;
      isTimerPaused = false;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!isTimerPaused && dietTimeInSeconds > 0) {
        setState(() {
          dietTimeInSeconds--;
        });
      } else if (dietTimeInSeconds <= 0) {
        timer.cancel();
        Navigator.pop(context); // 메인 화면으로 돌아감
      }
    });
  }

  void pauseOrResumeTimer() {
    setState(() {
      isTimerPaused = !isTimerPaused;
      if (!isTimerPaused) {
        startTimer(dietTimeInSeconds);
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer(widget.dietTimeInSeconds);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFF2E63),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 36,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButtonComponet(
                    onPressed: () {},
                    difficulty: 'Easy',
                    eatTime: 12,
                    dietTime: 12,
                    color: const Color.fromRGBO(37, 42, 52, 1),
                  ),
                  ElevatedButtonComponet(
                    onPressed: () {},
                    difficulty: 'Normal',
                    eatTime: 16,
                    dietTime: 8,
                    color: const Color.fromRGBO(37, 42, 52, 1),
                  ),
                  ElevatedButtonComponet(
                    onPressed: () {},
                    difficulty: 'Expert',
                    eatTime: 23,
                    dietTime: 1,
                    color: const Color.fromRGBO(8, 217, 214, 1),
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              const TextComponent(
                text: '금식시간',
                fontSize: 50,
              ),
              const SizedBox(
                height: 24,
              ),
              TextComponent(
                text:
                    '${(dietTimeInSeconds ~/ 3600).toString().padLeft(2, '0')}:${((dietTimeInSeconds % 3600) ~/ 60).toString().padLeft(2, '0')}:${(dietTimeInSeconds % 60).toString().padLeft(2, '0')}',
                fontSize: 80,
              ),
              const SizedBox(
                height: 48,
              ),
              const TextComponent(
                text: '간헐적단식 타이머',
                fontSize: 20,
              ),
              const SizedBox(
                height: 48,
              ),
              InkWell(
                onTap: pauseOrResumeTimer,
                child: const CirCleComponent(
                  insideColor: Color.fromRGBO(8, 217, 214, 1),
                  outsideColor: Color.fromRGBO(234, 234, 234, 1),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
