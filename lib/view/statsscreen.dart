import 'package:flutter/material.dart';
import 'package:flutterquizapp/provider/languageprovider.dart';
import 'package:flutterquizapp/provider/quizprovider.dart';
import 'package:flutterquizapp/provider/statsprovider.dart';
import 'package:flutterquizapp/ressource/strings.dart';
import 'package:flutterquizapp/widget/defaultbutton.dart';
import 'package:flutterquizapp/widget/statsoverview.dart';
import 'package:provider/provider.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
          width: MediaQuery.of(context).size.width,
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 50,
                    ),
                    SizedBox(
                      child: Text(
                          AppStrings.language[context
                              .read<LanguageProvider>()
                              .getLanguageCode()]!["stats_appbar_title"],
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 34,
                              fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                  ],
                ),
              ),
              StatsOverView(),
              DefaultButton(
                  btnText: AppStrings.language[context
                      .read<LanguageProvider>()
                      .getLanguageCode()]!["stats_mainmenubtn"],
                  onPressed: () {
                    context.read<StatsProvider>().clearstats();
                    context.read<QuizProvider>().resetQuestionIndex();
                    Navigator.popAndPushNamed(context, "/");
                  })
            ],
          )),
    );
  }
}
