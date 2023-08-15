import 'dart:isolate';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onetouchtimer/core/alarm/alarm.dart';
import 'package:onetouchtimer/presentation/diet/diet_controller.dart';
import 'package:onetouchtimer/presentation/main/main_screen.dart';
import 'presentation/main/main_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MainController());
    Get.put(DietController());
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          //fontFamily 지정
          primaryColor: Colors.white,
          fontFamily: 'NotoSansKR',
        ),
        home: const MainScreen());
    //       FutureBuilder(
    //         future: Future.delayed(
    //             const Duration(seconds: 3), () => "Intro Completed."),
    //         builder: (context, snapshot) {
    //           return AnimatedSwitcher(
    //               duration: const Duration(milliseconds: 1000),
    //               child: _splashLoadingWidget(snapshot));
    //         },
    //       ));
    // }
    //
    // Widget _splashLoadingWidget(AsyncSnapshot<Object?> snapshot) {
    //   if (snapshot.hasError) {
    //     return const Text("Error!!");
    //   } else if (snapshot.hasData) {
    //     return const MainScreen();
    //   } else {
    //     return const IntroScreen();
    //   }
    // }
  }
}
