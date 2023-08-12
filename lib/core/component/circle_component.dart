import 'package:flutter/material.dart';

class CirCleComponent extends StatelessWidget {
  final Color insideColor;
  final Color outsideColor;

  const CirCleComponent({
    Key? key, // key 파라미터 추가
    required this.insideColor,
    required this.outsideColor,
  }) : super(key: key); // key를 super 클래스에 전달

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: outsideColor,
          ),
        ),
        Container(
          width: 140,
          height: 140,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: insideColor,
          ),
        ),
      ],
    );
  }
}
