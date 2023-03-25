import 'package:flutter/material.dart';

class ScreenTitle extends StatelessWidget {
  final String titletext;
  final double? fontSize;
  final Color color;
  final FontWeight fontWeight;
  const ScreenTitle(
      {super.key,
      required this.titletext,
      this.fontSize = 50,
      this.color = Colors.white,
      this.fontWeight = FontWeight.bold});

  @override
  Widget build(BuildContext context) {
    return Text(
      titletext,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
      ),
    );
  }
}
