import 'package:firebase_database/firebase_database.dart';
import 'package:flutterquizapp/ressource/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateModel {
  DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
  bool updateAvailable = false;
  String version = "";
  String updateText = "Ein Update ist verfügbar";

  Future<bool> checkForUpdates(String languageCode) async {
    databaseRef = FirebaseDatabase.instance.ref().child("contentVersion");
    final prefs = await SharedPreferences.getInstance();

    await databaseRef.once().then((snapshot) async {
      var data = snapshot.snapshot;
      if (data.value == null) {
        throw Exception("aktuelle version existiert nicht!");
      } else if (prefs.getString("contentVersion") == null ||
          prefs.getStringList("categorylist${languageCode.toUpperCase()}") ==
              null ||
          prefs.getString("contentVersion") != data.value.toString()) {
        updateAvailable = true;
      } else {
        version = prefs.getString("contentVersion").toString();
        updateAvailable = false;
      }
    });

    return updateAvailable;
  }

  Future<void> initContentVersion() async {
    final prefs = await SharedPreferences.getInstance();
    databaseRef = FirebaseDatabase.instance.ref().child("contentVersion");

    if (updateAvailable) {
      await databaseRef.once().then((snapshot) {
        var data = snapshot.snapshot;
        if (data.value == null) {
          throw Exception(
              "Fehler bei der initalisierung der aktuellen Version!");
        } else {
          prefs.setString("contentVersion", data.value.toString());
          version = data.value.toString();
        }
      });
    } else if (prefs.getString("contentVersion") != null &&
        updateAvailable == false) {
      version = prefs.getString("contentVersion").toString();
    }
  }

  Future<void> initUpdateText(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    databaseRef = FirebaseDatabase.instance
        .ref()
        .child("updateText${languageCode.toUpperCase()}");
    if (prefs.getStringList("categorylist${languageCode.toUpperCase()}") ==
        null) {
      print("UpdateText: " + updateText);
      updateText = AppStrings.language[languageCode]!["update_load_first_time"];
      print("UpdateText: " + updateText);
    } else {
      await databaseRef.once().then((snapshot) {
        var data = snapshot.snapshot;
        updateText = data.value.toString();
        print("UpdateText: " + updateText);
      });
    }
  }

  bool getUpdateAvailable() {
    return updateAvailable;
  }

  void activateUpdateAvailable() {
    updateAvailable = true;
  }

  void deactivateUpdateAvailable() {
    updateAvailable = false;
  }
}
