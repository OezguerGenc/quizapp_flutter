import 'package:flutter/material.dart';
import 'package:flutterquizapp/model/question.dart';
import 'package:flutterquizapp/viewmodel/quizmodel.dart';

class QuizProvider with ChangeNotifier {
  final QuizModel quizModel = QuizModel();
  List<Question> questionlist = [];

  Future<bool> checkForUpdates(String languageCode) async {
    return await quizModel.checkForUpdates(languageCode);
  }

  Future<bool> checkSavedQuestions(String languageCode) async {
    return quizModel.checkSavedQuestions(languageCode);
  }

  String getContentVersion() {
    return quizModel.version;
  }

  Future<void> initQuestions(String languageCode) async {
    questionlist = (await quizModel.loadQuestions(languageCode))!;
    notifyListeners();
  }

  void increaseQuestionIndex() {
    quizModel.increaseQuestionIndex();
    notifyListeners();
  }

  bool checkAnswer() {
    return questionlist[getQuestionIndex()]
        .answers[getIsSelectedIndex()]
        .correct;
  }

  void activateUpdateAvailable() {
    quizModel.activateUpdateAvailable();
    notifyListeners();
  }

  bool getUpdateAvailable() {
    return quizModel.getUpdateAvailable();
  }

  bool getLoadingQuestions() {
    return quizModel.loadingQuestions;
  }

  void loadingQuestionsStart() {
    quizModel.loadingQuestionsStart();
    notifyListeners();
  }

  void loadingQuestionsCompleted() {
    quizModel.loadingQuestionsCompleted();
    notifyListeners();
  }

  Future<void> initContentVersion() async {
    await quizModel.initContentVersion();
    notifyListeners();
  }

  bool checkIsLastQuestion() {
    return quizModel.questionindex < questionlist.length - 1;
  }

  int getQuestionIndex() {
    return quizModel.questionindex;
  }

  List<bool> getIsSelected() {
    return quizModel.isSelectedList;
  }

  int getIsSelectedIndex() {
    return quizModel.isSelectedIndex;
  }

  void toggleIsSelected(int index) {
    quizModel.toggleIsSelected(index);
    notifyListeners();
  }

  void resetQuestionIndex() {
    quizModel.resetQuestionIndex();
  }

  void changeQuestionListPath(String languageTitle) {
    quizModel.changeQuestionListPath(languageTitle);
  }
}
