import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:onetouchtimer/core/component/circle_component.dart';
import 'package:onetouchtimer/core/component/elevatedbutton_component.dart';
import 'package:onetouchtimer/core/component/text_component.dart';
import 'package:onetouchtimer/presentation/main/main_controller.dart';

class MainScreen extends GetView<MainController> with WidgetsBindingObserver {
  const MainScreen({super.key});

  void onInit() {
    WidgetsBinding.instance.addObserver(this);
    controller.restoreSavedData();
  }

  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // Handle app going to the background
    } else if (state == AppLifecycleState.resumed) {
      // Handle app coming back to the foreground
    }
  }

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
                  Expanded(
                    child: ElevatedButtonComponet(
                      onPressed: () => controller.startTimer(12, 12),
                      difficulty: 'Easy',
                      eatTime: 12,
                      dietTime: 12,
                      color: const Color.fromRGBO(37, 42, 52, 1),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButtonComponet(
                      onPressed: () => controller.startTimer(8, 16),
                      difficulty: 'Normal',
                      eatTime: 8,
                      dietTime: 16,
                      color: const Color.fromRGBO(37, 42, 52, 1),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButtonComponet(
                      onPressed: () => controller.startTimer(1, 23),
                      difficulty: 'Expert',
                      eatTime: 1,
                      dietTime: 23,
                      color: const Color(0xFFFF2E63),
                    ),
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
                onTap: () {
                  controller.pauseOrResumeTimer();
                },
                child: const CirCleComponent(
                  insideColor: Color.fromRGBO(255, 46, 99, 1),
                  outsideColor: Color.fromRGBO(234, 234, 234, 1),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        controller.startTimer1(30, 30);
                      },
                      child: const Text('test'),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        controller.clearSavedData();
                      },
                      child: const Text('test'),
                    ),
                  ),
                ],
              ),
              if (controller.bannerAd != null) // Access the bannerAd property
                SizedBox(
                  width: controller.bannerAd!.size.width.toDouble(),
                  height: controller.bannerAd!.size.height.toDouble(),
                  child: AdWidget(ad: controller.bannerAd!),
                )
            ],
          ),
        ),
      ),
    );
  }
}
