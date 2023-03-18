import 'package:flutter/material.dart';
import 'package:flutterquizapp/provider/languageprovider.dart';
import 'package:flutterquizapp/ressource/strings.dart';
import 'package:flutterquizapp/widget/menubutton.dart';
import 'package:provider/provider.dart';
import '../provider/quizprovider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.language,
              color: Colors.white,
            ),
            onPressed: () {
              _openLanguageSelectionDialog(context);
            },
          ),
        ],
        title: Text(
            AppStrings.language[context
                .read<LanguageProvider>()
                .getLanguageCode()]!["mainmenu_appbar_title"],
            style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 40.0),
              child: Text(
                AppStrings.language[context
                    .read<LanguageProvider>()
                    .getLanguageCode()]!["mainmenu_title"],
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
                        await context.read<QuizProvider>().initQuestions(
                            context.read<LanguageProvider>().getLanguageCode());
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
            SizedBox(
              width: 100,
              height: 100,
              child: Padding(
                padding: EdgeInsets.only(bottom: 40.0),
                child: Text(
                  AppStrings.language[context
                      .read<LanguageProvider>()
                      .getLanguageCode()]!["mainmenu_madeby"],
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

  void _openLanguageSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sprache auswählen'),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: context
                  .watch<LanguageProvider>()
                  .getAvailableLanguages()
                  .length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(context
                      .watch<LanguageProvider>()
                      .getAvailableLanguages()[index]),
                  trailing: Image.asset(
                      context.read<LanguageProvider>().getFlagImagePath(index)),
                  onTap: () {
                    // Hier wird der Code ausgeführt, wenn eine Sprache ausgewählt wird
                    context.read<LanguageProvider>().switchLanguage(context
                        .read<LanguageProvider>()
                        .getAvailableLanguages()[index]);
                    context.read<QuizProvider>().changeQuestionListPath(context
                        .read<LanguageProvider>()
                        .getAvailableLanguages()[index]);
                    setState(() {});
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        );
      },
    ).then((selectedLanguage) {
      // Hier wird der Code ausgeführt, wenn eine Sprache ausgewählt und der Dialog geschlossen wurde
      if (selectedLanguage != null) {
        // Hier können Sie die ausgewählte Sprache verwenden
        print('Die ausgewählte Sprache ist: $selectedLanguage');
      }
    });
  }
}
