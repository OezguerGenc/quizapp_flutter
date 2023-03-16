import 'package:flutter/material.dart';
import 'package:flutterquizapp/model/question.dart';
import 'package:flutterquizapp/viewmodel/quizmodel.dart';

class QuizProvider with ChangeNotifier {
  final QuizModel quizModel = QuizModel();

  List<Question> questionlist = [];

  Future initQuestions() async {
    questionlist = await quizModel.loadQuestions();
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
}
