import 'package:flutter/material.dart';
import 'package:flutterquizapp/model/question.dart';
import 'package:flutterquizapp/viewmodel/quizmodel.dart';

class QuizProvider with ChangeNotifier {
  final QuizModel quizModel = QuizModel();

  List<Question> questionlist = [];

  Future<void> initQuestions() async {
    questionlist = await quizModel.loadQuestions();
  }
}
