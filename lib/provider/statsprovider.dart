import 'package:flutter/material.dart';
import 'package:flutterquizapp/viewmodel/statsmodel.dart';

class StatsProvider with ChangeNotifier {
  final StatsModel statsModel = StatsModel();

  void increaseright() {
    statsModel.increaseright();
  }

  void increasenotright() {
    statsModel.increasenotright();
  }

  int getRight() {
    return statsModel.rightanswer;
  }

  int getNotRight() {
    return statsModel.notrightanswer;
  }

  void clearstats() {
    statsModel.clearstats();
  }
}
