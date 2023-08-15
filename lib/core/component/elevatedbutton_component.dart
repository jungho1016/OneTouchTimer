import 'package:flutter/material.dart';

import 'text_component.dart';

class ElevatedButtonComponet extends StatelessWidget {
  const ElevatedButtonComponet(
      {Key? key,
      required this.onPressed,
      required this.difficulty,
      required this.eatTime,
      required this.dietTime,
      required this.color})
      : super(key: key);
  final VoidCallback onPressed;
  final String difficulty;
  final int eatTime;
  final int dietTime;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 100,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            // const Color.fromRGBO(255, 46, 99, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0), // 버튼 모서리 굴곡
            ),
          ),
          child: Column(
            children: [
              TextComponent(text: difficulty, fontSize: 16),
              TextComponent(text: '$dietTime:$eatTime', fontSize: 24),
            ],
          ),
        ),
      ),
    );
  }
}
