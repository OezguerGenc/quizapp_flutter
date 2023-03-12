import 'package:flutter/material.dart';
import 'package:flutterquizapp/widget/answerbutton.dart';
import 'package:flutterquizapp/widget/questioncard.dart';

class QuizScreen extends StatelessWidget {
  QuizScreen({Key? key}) : super(key: key);

  bool isSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Quiz',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          QuestionCard(text: "Test"),
          AnswerButton(text: "text", isSelected: isSelected, onSelect: () {})
        ],
      ),
    );
  }
}
