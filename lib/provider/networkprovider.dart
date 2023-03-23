import 'package:flutter/cupertino.dart';
import 'package:flutterquizapp/viewmodel/networkmodel.dart';

class NetworkProvider with ChangeNotifier {
  final NetworkModel networkModel = NetworkModel();

  Future<bool> connectedWithNetwork() {
    return networkModel.connectedWithNetwork();
  }
}
