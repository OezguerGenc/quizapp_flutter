import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterquizapp/model/dialogs.dart';
import 'package:flutterquizapp/provider/languageprovider.dart';
import 'package:flutterquizapp/provider/quizprovider.dart';
import 'package:flutterquizapp/provider/themeprovider.dart';
import 'package:flutterquizapp/provider/updateprovider.dart';
import 'package:flutterquizapp/ressource/strings.dart';
import 'package:flutterquizapp/widget/buttons/menubutton.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ButtonMenu extends StatelessWidget {
  const ButtonMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        context.watch<QuizProvider>().quizModel.loadingQuestions
            ? Platform.isAndroid
                ? const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: CircularProgressIndicator(),
                  )
                : const CupertinoActivityIndicator()
            : MenuButton(
                btnText: AppStrings.language[context
                    .read<LanguageProvider>()
                    .getLanguageCode()]!["mainmenu_startbtn"],
                animated: true,
                onPressed: () async {
                  try {
                    if (await context.read<QuizProvider>().checkSavedQuestions(
                        context
                            .read<LanguageProvider>()
                            .getLanguageCode()
                            .toUpperCase())) {
                      await context.read<UpdateProvider>().initUpdateText(
                          context.read<LanguageProvider>().getLanguageCode());
                      Dialogs().openUpdateDialog(context);
                    } else {
                      context.read<QuizProvider>().loadingQuestionsStart();
                      await context.read<QuizProvider>().initQuestions(
                          context.read<LanguageProvider>().getLanguageCode());
                      await context.read<UpdateProvider>().initContentVersion();
                      context.read<QuizProvider>().loadingQuestionsCompleted();
                      context
                          .read<UpdateProvider>()
                          .deactivateUpdateAvailable();
                      Navigator.pushNamed(context, "quizscreen");
                    }
                  } catch (error) {
                    Dialogs().openErrorDialog(context, error.toString());
                  }
                },
              ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
        ),
        MenuButton(
            btnText: AppStrings.language[context
                .read<LanguageProvider>()
                .getLanguageCode()]!["mainmenu_creditsbtn"],
            width: 250,
            onPressed: () async {
              context.read<ThemeProvider>().toggleTheme();

              final prefs = await SharedPreferences.getInstance();
              prefs.clear();
            })
      ],
    );
  }
}
