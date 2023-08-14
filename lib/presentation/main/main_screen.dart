import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onetouchtimer/core/component/circle_component.dart';
import 'package:onetouchtimer/core/component/elevatedbutton_component.dart';
import 'package:onetouchtimer/core/component/text_component.dart';
import 'package:onetouchtimer/presentation/main/main2_screen.dart';
import 'package:onetouchtimer/presentation/main/main_controller.dart';

class MainScreen extends GetView<MainController> {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff08d9d6),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 36),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButtonComponet(
                    onPressed: () => controller.startTimer(12),
                    difficulty: 'Easy',
                    eatTime: 12,
                    dietTime: 12,
                    color: const Color.fromRGBO(37, 42, 52, 1),
                  ),
                  ElevatedButtonComponet(
                    onPressed: () => controller.startTimer(8),
                    difficulty: 'Normal',
                    eatTime: 8,
                    dietTime: 16,
                    color: const Color.fromRGBO(37, 42, 52, 1),
                  ),
                  ElevatedButtonComponet(
                    onPressed: () => controller.startTimer(1),
                    difficulty: 'Expert',
                    eatTime: 1,
                    dietTime: 23,
                    color: const Color(0xFFFF2E63),
                  ),
                ],
              ),
              const SizedBox(height: 48),
              const TextComponent(
                text: '식사시간',
                fontSize: 50,
              ),
              const SizedBox(height: 24),
              GetBuilder<MainController>(
                builder: (controller) {
                  final hours = controller.eatTimeInSeconds ~/ 3600;
                  final minutes = (controller.eatTimeInSeconds % 3600) ~/ 60;
                  final seconds = controller.eatTimeInSeconds % 60;
                  return TextComponent(
                    text:
                        '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
                    fontSize: 80,
                  );
                },
              ),
              const SizedBox(height: 48),
              const TextComponent(
                text: '간헐적단식 타이머',
                fontSize: 20,
              ),
              const SizedBox(height: 48),
              InkWell(
                onTap: controller.pauseOrResumeTimer,
                child: const CirCleComponent(
                  insideColor: Color.fromRGBO(255, 46, 99, 1),
                  outsideColor: Color.fromRGBO(234, 234, 234, 1),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  controller.startTimer1(3);
                  // Get.to(const Main2Screen(
                  //   dietTimeInSeconds: 3,
                  // ));
                },
                child: const Text('test'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
