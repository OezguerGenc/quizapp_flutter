import 'package:flutter/material.dart';
import 'package:flutterquizapp/provider/languageprovider.dart';
import 'package:flutterquizapp/provider/networkprovider.dart';
import 'package:flutterquizapp/provider/quizprovider.dart';
import 'package:flutterquizapp/ressource/strings.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dialogs {
  void openErrorDialog(BuildContext context, String errormessage) {
    showDialog(
      context: context,
      builder: (context2) => AlertDialog(
        title: const Text('Fehler'),
        content: Text(errormessage),
        actions: [
          TextButton(
            onPressed: () => {
              context.read<QuizProvider>().loadingQuestionsCompleted(),
              Navigator.pop(context)
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void openLanguageSelectionDialog(BuildContext context) {
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
                  onTap: () async {
                    // Hier wird der Code ausgeführt, wenn eine Sprache ausgewählt wird
                    context.read<LanguageProvider>().switchLanguage(context
                        .read<LanguageProvider>()
                        .getAvailableLanguages()[index]);
                    context.read<QuizProvider>().changeQuestionListPath(context
                        .read<LanguageProvider>()
                        .getAvailableLanguages()[index]);

                    if (await context.read<QuizProvider>().checkForUpdates(
                        context.read<LanguageProvider>().getLanguageCode())) {
                      await context
                          .read<QuizProvider>()
                          .quizModel
                          .initUpdateText(context
                              .read<LanguageProvider>()
                              .getLanguageCode());
                      Navigator.pop(context);
                      openUpdateDialog(context);
                    } else {
                      Navigator.pop(context);
                    }
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

  void openUpdateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context2) {
        return AlertDialog(
          title: Text(AppStrings.language[context
              .read<LanguageProvider>()
              .getLanguageCode()]!["update_title"]),
          titleTextStyle: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
          actionsOverflowButtonSpacing: 20,
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context2);
                },
                child: Text(AppStrings.language[context
                    .read<LanguageProvider>()
                    .getLanguageCode()]!["update_laterbtn"])),
            ElevatedButton(
                onPressed: () async {
                  try {
                    if (await context
                        .read<NetworkProvider>()
                        .connectedWithNetwork()) {
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();

                      Navigator.pop(context);
                      await prefs.remove(
                          "questionlist${context.read<LanguageProvider>().getLanguageCode().toUpperCase()}");

                      context.read<QuizProvider>().loadingQuestionsStart();

                      await context.read<QuizProvider>().initQuestions(
                          context.read<LanguageProvider>().getLanguageCode());

                      await context.read<QuizProvider>().initContentVersion();

                      context.read<QuizProvider>().loadingQuestionsCompleted();
                    } else {
                      throw Exception(AppStrings.language[context
                          .read<LanguageProvider>()
                          .getLanguageCode()]!["exception_network_connection"]);
                    }
                  } catch (e) {
                    openErrorDialog(context, e.toString());
                  }
                },
                child: Text(AppStrings.language[context
                    .read<LanguageProvider>()
                    .getLanguageCode()]!["update_downloadbtn"])),
          ],
          content: Text(context.watch<QuizProvider>().quizModel.updateText),
        );
      },
    );
  }
}
