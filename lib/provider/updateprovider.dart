import 'package:flutter/cupertino.dart';
import 'package:flutterquizapp/viewmodel/updatemodel.dart';

class UpdateProvider with ChangeNotifier {
  final UpdateModel updateModel = UpdateModel();

  Future<bool> checkForUpdates(String languageCode) async {
    return await updateModel.checkForUpdates(languageCode);
  }

  Future<void> initContentVersion() async {
    await updateModel.initContentVersion();
    notifyListeners();
  }

  Future<void> initUpdateText(String languageCode) async {
    await updateModel.initUpdateText(languageCode);
    notifyListeners();
  }

  bool getUpdateAvailable() {
    return updateModel.getUpdateAvailable();
  }

  void activateUpdateAvailable() {
    updateModel.activateUpdateAvailable();
    notifyListeners();
  }

  void deactivateUpdateAvailable() {
    updateModel.deactivateUpdateAvailable();
    notifyListeners();
  }

  String getUpdateText() {
    return updateModel.updateText;
  }

  String getContentVersion() {
    return updateModel.version;
  }
}
