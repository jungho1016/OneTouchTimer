import 'package:flutter/material.dart';

class TextComponent extends StatelessWidget {
  const TextComponent({Key? key, required this.text, required this.fontSize})
      : super(key: key);
  final String text;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ));
  }
}
