import 'package:shared_preferences/shared_preferences.dart';

class LanguageModel {
  String languageCode = "de";
  String languageTitle = "Deutsch";
  List<String> availableLanguages = ['Deutsch', 'English'];
  List<String> flagimagepaths = [
    "lib/assets/flags/de.png",
    "lib/assets/flags/uk.png"
  ];

  Future<void> loadLastSelectedLanguage() async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getString("language") != null &&
        prefs.getString("language") != languageTitle) {
      switchLanguage(prefs.getString("language")!);
    }
  }

  void switchLanguage(String newlanguageTitle) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("language", newlanguageTitle);
    languageTitle = newlanguageTitle;
    switch (newlanguageTitle) {
      case "Deutsch":
        languageCode = "de";
        break;
      case "English":
        languageCode = "en";
        break;
      default:
    }
  }
}
