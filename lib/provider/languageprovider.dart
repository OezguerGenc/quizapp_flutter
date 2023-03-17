import 'package:flutter/material.dart';
import 'package:flutterquizapp/viewmodel/languagemodel.dart';

class LanguageProvider with ChangeNotifier {
  LanguageModel languageModel = LanguageModel();

  void switchLanguage(String newlanguageTitle) {
    languageModel.switchLanguage(newlanguageTitle);
    notifyListeners();
  }

  String getFlagImagePath(int index) {
    return languageModel.flagimagepaths[index];
  }

  String getLanguageCode() {
    return languageModel.languageCode;
  }

  String getLanguageTitle() {
    return languageModel.languageTitle;
  }

  List<String> getAvailableLanguages() {
    return languageModel.availableLanguages;
  }
}
