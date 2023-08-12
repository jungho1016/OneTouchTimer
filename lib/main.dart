import 'package:flutter/material.dart';
import 'package:onetouchtimer/presentation/intro/intro_screen.dart';
import 'package:onetouchtimer/presentation/main/main_screen.dart';

import 'presentation/main/main2_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          //fontFamily 지정
          primaryColor: Colors.white,

          fontFamily: 'NotoSansKR',
        ),
        home: const Main2Screen());
    // FutureBuilder(
    //   future: Future.delayed(
    //       const Duration(seconds: 3), () => "Intro Completed."),
    //   builder: (context, snapshot) {
    //     return AnimatedSwitcher(
    //         duration: const Duration(milliseconds: 1000),
    //         child: _splashLoadingWidget(snapshot));
    //   },
    // ));
  }

  Widget _splashLoadingWidget(AsyncSnapshot<Object?> snapshot) {
    if (snapshot.hasError) {
      return const Text("Error!!");
    } else if (snapshot.hasData) {
      return const MainScreen();
    } else {
      return const IntroScreen();
    }
  }
}
