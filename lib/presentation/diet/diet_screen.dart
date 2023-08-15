import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onetouchtimer/core/component/circle_component.dart';
import 'package:onetouchtimer/core/component/elevatedbutton_component.dart';
import 'package:onetouchtimer/core/component/text_component.dart';

import 'package:onetouchtimer/presentation/diet/diet_controller.dart';

class DietScreen extends GetView<DietController> {
  final int dietTimeInSeconds;

  const DietScreen({required this.dietTimeInSeconds});

  @override
  Widget build(BuildContext context) {
    controller.startTimer(dietTimeInSeconds);
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
              GetBuilder<DietController>(
                builder: (controller) {
                  final hours = controller.dietTimeInSeconds ~/ 3600;
                  final minutes = (controller.dietTimeInSeconds % 3600) ~/ 60;
                  final seconds = controller.dietTimeInSeconds % 60;
                  return TextComponent(
                    text:
                        '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
                    fontSize: 80,
                  );
                },
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
                onTap: controller.pauseOrResumeTimer,
                child: const CirCleComponent(
                  insideColor: Color.fromRGBO(8, 217, 214, 1),
                  outsideColor: Color.fromRGBO(234, 234, 234, 1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
