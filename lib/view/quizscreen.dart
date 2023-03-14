import 'package:flutter/material.dart';
import 'package:flutterquizapp/provider/quizprovider.dart';
import 'package:flutterquizapp/widget/answerbutton.dart';
import 'package:flutterquizapp/widget/questioncard.dart';
import 'package:provider/provider.dart';

class QuizScreen extends StatelessWidget {
  QuizScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Quiz',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          QuestionCard(
              text: context
                  .watch<QuizProvider>()
                  .questionlist[context.read<QuizProvider>().getQuestionIndex()]
                  .text),
          AnswerButton(
              text: context
                  .watch<QuizProvider>()
                  .questionlist[context.read<QuizProvider>().getQuestionIndex()]
                  .answers[0]
                  .text,
              isSelected: context.read<QuizProvider>().getIsSelected().first,
              onSelect: () {
                context.read<QuizProvider>().toggleIsSelected(0);
              }),
          AnswerButton(
              text: context
                  .watch<QuizProvider>()
                  .questionlist[context.read<QuizProvider>().getQuestionIndex()]
                  .answers[1]
                  .text,
              isSelected: context.read<QuizProvider>().getIsSelected()[1],
              onSelect: () {
                context.read<QuizProvider>().toggleIsSelected(1);
              }),
        ],
      ),
    );
  }
}
