import 'package:flutter/material.dart';
import 'package:flutterquizapp/widget/questioncard.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({Key? key}) : super(key: key);

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
        children: [QuestionCard(text: "Test")],
      ),
    );
  }
}
