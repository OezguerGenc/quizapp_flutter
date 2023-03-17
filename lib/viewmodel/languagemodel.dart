class LanguageModel {
  String languageCode = "de";
  String languageTitle = "Deutsch";
  List<String> availableLanguages = ['Deutsch', 'English'];
  List<String> flagimagepaths = [
    "lib/assets/flags/de.png",
    "lib/assets/flags/uk.png"
  ];

  void switchLanguage(String newlanguageTitle) {
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
