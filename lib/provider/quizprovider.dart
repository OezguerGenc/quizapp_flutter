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
    quizModel.questionindex++;
    notifyListeners();
  }

  int getQuestionIndex() {
    return quizModel.questionindex;
  }

  List<bool> getIsSelected() {
    return quizModel.isSelectedList;
  }

  void toggleIsSelected(int index) {
    quizModel.toggleIsSelected(index);
    notifyListeners();
  }
}
