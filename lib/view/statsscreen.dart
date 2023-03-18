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
      appBar: AppBar(
        title: Text(
          AppStrings.language[context
              .read<LanguageProvider>()
              .getLanguageCode()]!["stats_appbar_title"],
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(),
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
