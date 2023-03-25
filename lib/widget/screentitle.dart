import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterquizapp/provider/languageprovider.dart';
import 'package:flutterquizapp/ressource/strings.dart';
import 'package:provider/provider.dart';

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
