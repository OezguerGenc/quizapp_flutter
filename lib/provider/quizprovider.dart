import 'package:flutter/material.dart';
import 'package:flutterquizapp/viewmodel/quizmodel.dart';

class QuizProvider with ChangeNotifier {
  final QuizModel quizModel = QuizModel();
}
