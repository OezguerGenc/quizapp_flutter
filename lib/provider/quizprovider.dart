import 'package:flutter/material.dart';
import 'package:flutterquizapp/model/category.dart';
import 'package:flutterquizapp/viewmodel/quizmodel.dart';

class QuizProvider with ChangeNotifier {
  final QuizModel quizModel = QuizModel();
  //List<Question> questionlist = [];
  List<Category> categorylist = [];

  Future<bool> checkSavedQuestions(String languageCode) async {
    return quizModel.checkSavedQuestions(languageCode);
  }

  Future<void> initQuestions(String languageCode) async {
    categorylist = (await quizModel.loadQuestions(languageCode))!;

    notifyListeners();
  }

  void increaseQuestionIndex() {
    quizModel.increaseQuestionIndex();
    notifyListeners();
  }

  bool checkAnswer() {
    return categorylist[0]
        .questions[getQuestionIndex()]
        .answers[getIsSelectedIndex()]
        .correct;
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

  bool checkIsLastQuestion() {
    return quizModel.questionindex < categorylist[0].questions.length - 1;
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

  Future<void> initCategoryCount() async {
    return await quizModel.initCategoryCount();
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
