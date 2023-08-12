import 'package:flutter/material.dart';
import 'package:onetouchtimer/core/component/circle_component.dart';
import 'package:onetouchtimer/core/component/elevatedbutton_component.dart';
import 'package:onetouchtimer/core/component/text_component.dart';

class Main2Screen extends StatelessWidget {
  const Main2Screen({Key? key}) : super(key: key);

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
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButtonComponet(
                    onpressed: () {},
                    difficulty: 'Easy',
                    eatTime: 12,
                    dietTime: 12,
                    color: const Color.fromRGBO(37, 42, 52, 1),
                  ),
                  ElevatedButtonComponet(
                    onpressed: () {},
                    difficulty: 'Normal',
                    eatTime: 16,
                    dietTime: 8,
                    color: const Color.fromRGBO(37, 42, 52, 1),
                  ),
                  ElevatedButtonComponet(
                    onpressed: () {},
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
              const TextComponent(
                text: '01:00',
                fontSize: 80,
              ),
              const SizedBox(
                height: 96,
              ),
              const TextComponent(
                text: '간헐적단식 개꿀띠',
                fontSize: 20,
              ),
              const SizedBox(
                height: 96,
              ),
              const CirCleComponent(
                insideColor: Color.fromRGBO(8, 217, 214, 1),
                outsideColor: Color.fromRGBO(234, 234, 234, 1),
              )
            ],
          ),
        ),
      ),
    );
  }
}
