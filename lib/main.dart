import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onetouchtimer/presentation/intro/intro_screen.dart';
import 'package:onetouchtimer/presentation/main/main_screen.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

import 'presentation/main/main_controller.dart';
import 'presentation/main/second_screen.dart';

// Be sure to annotate your callback function to avoid issues in release mode on Flutter >= 3.3.0
@pragma('vm:entry-point')
void printHello() {
  final DateTime now = DateTime.now();
  final int isolateId = Isolate.current.hashCode;
  print("[$now] Hello, world! isolate=$isolateId function='$printHello'");
}

void main() async {
  // Very important to call before initialize since it
  // ensures the binding is available and ready before
  // any native call
  WidgetsFlutterBinding.ensureInitialized();

  await AndroidAlarmManager.initialize();

  runApp(const MyApp());

  const int helloAlarmID = 0;
  await AndroidAlarmManager.periodic(
      const Duration(minutes: 1), helloAlarmID, printHello);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MainController());
    return GetMaterialApp(
        theme: ThemeData(
          //fontFamily 지정
          primaryColor: Colors.white,

          fontFamily: 'NotoSansKR',
        ),
        home: MainScreen());
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
