class StatsModel {
  int rightanswer = 0;
  int notrightanswer = 0;

  void checkAnswer() {}

  void increaseright() {
    rightanswer++;
  }

  void increasenotright() {
    notrightanswer++;
  }

  void clearstats() {
    rightanswer = 0;
    notrightanswer = 0;
  }
}
