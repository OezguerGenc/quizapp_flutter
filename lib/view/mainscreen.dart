import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterquizapp/provider/languageprovider.dart';
import 'package:flutterquizapp/provider/networkprovider.dart';
import 'package:flutterquizapp/ressource/strings.dart';
import 'package:flutterquizapp/widget/menubutton.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../provider/quizprovider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        if (await context.read<QuizProvider>().checkForUpdates(
            context.read<LanguageProvider>().getLanguageCode().toUpperCase())) {
          await context.read<QuizProvider>().quizModel.initUpdateText(
              context.read<LanguageProvider>().getLanguageCode());

          context.read<QuizProvider>().activateUpdateAvailable();

          _openUpdateDialog();
        } else {
          context.read<QuizProvider>().initContentVersion();
        }
      } catch (e) {
        _openErrorDialog(context, e.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.red, Colors.blue],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    context.watch<QuizProvider>().getUpdateAvailable()
                        ? SizedBox(
                            width: 50,
                            child: IconButton(
                              icon: Icon(
                                Icons.file_download,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                _openUpdateDialog();
                              },
                            ),
                          )
                        : SizedBox(
                            width: 50,
                          ),
                    SizedBox(
                      child: Text(
                          AppStrings.language[context
                              .read<LanguageProvider>()
                              .getLanguageCode()]!["mainmenu_appbar_title"],
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(
                      width: 50,
                      child: IconButton(
                        icon: Icon(
                          Icons.language,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          _openLanguageSelectionDialog(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Text(
                          AppStrings.language[context
                              .read<LanguageProvider>()
                              .getLanguageCode()]!["mainmenu_title"],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 50,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    Column(
                      children: [
                        context.watch<QuizProvider>().quizModel.loadingQuestions
                            ? Platform.isAndroid
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: const CircularProgressIndicator(),
                                  )
                                : const CupertinoActivityIndicator()
                            : MenuButton(
                                btnText: AppStrings.language[context
                                    .read<LanguageProvider>()
                                    .getLanguageCode()]!["mainmenu_startbtn"],
                                animated: true,
                                onPressed: () async {
                                  try {
                                    if (await context
                                        .read<QuizProvider>()
                                        .checkSavedQuestions(context
                                            .read<LanguageProvider>()
                                            .getLanguageCode()
                                            .toUpperCase())) {
                                      _openUpdateDialog();
                                    } else {
                                      context
                                          .read<QuizProvider>()
                                          .loadingQuestionsStart();
                                      await context
                                          .read<QuizProvider>()
                                          .initQuestions(context
                                              .read<LanguageProvider>()
                                              .getLanguageCode());
                                      await context
                                          .read<QuizProvider>()
                                          .initContentVersion();
                                      context
                                          .read<QuizProvider>()
                                          .loadingQuestionsCompleted();
                                      Navigator.pushNamed(
                                          context, "quizscreen");
                                    }
                                  } catch (error) {
                                    _openErrorDialog(context, error.toString());
                                  }
                                },
                              ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                        ),
                        MenuButton(
                            btnText: AppStrings.language[context
                                .read<LanguageProvider>()
                                .getLanguageCode()]!["mainmenu_creditsbtn"],
                            width: 250,
                            onPressed: () async {})
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(
                          width: 100,
                          height: 100,
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
                        SizedBox(
                          width: 200,
                          height: 50,
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              context.watch<QuizProvider>().getContentVersion(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openErrorDialog(BuildContext context, String errormessage) {
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
                      _openUpdateDialog();
                    } else {
                      Navigator.pop(context);
                    }
                    setState(() {});
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

  void _openUpdateDialog() {
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
                  Navigator.pop(context);
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
                    _openErrorDialog(context, e.toString());
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
