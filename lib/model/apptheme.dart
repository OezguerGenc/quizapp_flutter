import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.red,
      hintColor: Colors.blue,
      hoverColor: Colors.black);

  static final darkTheme = ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.black,
      hintColor: Color.fromARGB(255, 0, 74, 135),
      dialogTheme: DialogTheme(
        backgroundColor: Colors.black,
        titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
        contentTextStyle:
            TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
      dialogBackgroundColor: Colors.grey,
      hoverColor: Colors.white);
}
