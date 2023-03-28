import 'package:flutter/material.dart';
import 'package:flutterquizapp/provider/languageprovider.dart';
import 'package:flutterquizapp/provider/quizprovider.dart';
import 'package:flutterquizapp/provider/statsprovider.dart';
import 'package:flutterquizapp/ressource/strings.dart';
import 'package:flutterquizapp/widget/buttons/answerbutton.dart';
import 'package:flutterquizapp/widget/buttons/nextbutton.dart';
import 'package:flutterquizapp/widget/questioncard.dart';
import 'package:flutterquizapp/widget/topbar.dart';
import 'package:provider/provider.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).hintColor
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TopBar(
                    title: AppStrings.language[context
                        .read<LanguageProvider>()
                        .getLanguageCode()]!["quiz_appbar_title"])),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                QuestionCard(
                    text: context
                        .watch<QuizProvider>()
                        .categorylist[context
                            .read<QuizProvider>()
                            .quizModel
                            .categoryindex]
                        .questions[
                            context.read<QuizProvider>().getQuestionIndex()]
                        .text),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AnswerButton(
                          text: context
                              .watch<QuizProvider>()
                              .categorylist[context
                                  .read<QuizProvider>()
                                  .quizModel
                                  .categoryindex]
                              .questions[context
                                  .read<QuizProvider>()
                                  .getQuestionIndex()]
                              .answers[0]
                              .text,
                          isSelected: context
                              .read<QuizProvider>()
                              .getIsSelected()
                              .first,
                          onSelect: () {
                            context.read<QuizProvider>().toggleIsSelected(0);
                          }),
                      AnswerButton(
                          text: context
                              .watch<QuizProvider>()
                              .categorylist[context
                                  .read<QuizProvider>()
                                  .quizModel
                                  .categoryindex]
                              .questions[context
                                  .read<QuizProvider>()
                                  .getQuestionIndex()]
                              .answers[1]
                              .text,
                          isSelected:
                              context.read<QuizProvider>().getIsSelected()[1],
                          onSelect: () {
                            context.read<QuizProvider>().toggleIsSelected(1);
                          }),
                    ],
                  ),
                ),
                NextButton(onPressed: () {
                  if (context.read<QuizProvider>().checkAnswer()) {
                    context.read<StatsProvider>().increaseright();
                  } else {
                    context.read<StatsProvider>().increasenotright();
                  }
                  if (context.read<QuizProvider>().checkIsLastQuestion()) {
                    context.read<QuizProvider>().increaseQuestionIndex();
                  } else {
                    Navigator.popAndPushNamed(context, "statsscreen");
                  }
                })
              ],
            ),
          ],
        ),
      ),
    );
  }
}
