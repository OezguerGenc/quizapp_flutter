import 'package:flutter/material.dart';
import 'package:flutterquizapp/model/apptheme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  bool isDarkMode = false;
  SharedPreferences? _prefs;

  ThemeProvider() {
    _loadFromPrefs();
  }

  void toggleTheme() async {
    isDarkMode = !isDarkMode;
    _saveToPrefs();
    notifyListeners();
  }

  ThemeData getTheme() {
    return isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme;
  }

  _initPrefs() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
  }

  _loadFromPrefs() async {
    await _initPrefs();
    isDarkMode = _prefs!.getBool('isDarkMode') ?? false;
    notifyListeners();
  }

  _saveToPrefs() async {
    await _initPrefs();
    _prefs!.setBool('isDarkMode', isDarkMode);
  }
}
