import 'package:flutter/material.dart';
import 'package:flutterquizapp/widget/menubutton.dart';
import 'package:provider/provider.dart';
import '../provider/quizprovider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Hauptmenü', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 40.0),
              child: Text(
                'QuizApp',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 40, color: Colors.white),
              ),
            ),
            context.watch<QuizProvider>().quizModel.loadingQuestions
                ? CircularProgressIndicator()
                : MenuButton(
                    onPressed: () async {
                      context.read<QuizProvider>().loadingQuestionsStart();
                      try {
                        await context.read<QuizProvider>().initQuestions();
                        if (context
                            .read<QuizProvider>()
                            .questionlist
                            .isNotEmpty) {
                          context
                              .read<QuizProvider>()
                              .loadingQuestionsCompleted();
                          Navigator.pushNamed(context, "quizscreen");
                        }
                      } catch (e) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Fehler'),
                            content: Text(e.toString()),
                            actions: [
                              TextButton(
                                onPressed: () => {
                                  context
                                      .read<QuizProvider>()
                                      .loadingQuestionsCompleted(),
                                  Navigator.pop(context)
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
            const SizedBox(
              width: 100,
              height: 100,
              child: Padding(
                padding: EdgeInsets.only(bottom: 40.0),
                child: Text(
                  'Made by\nÖzgür Genc',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
