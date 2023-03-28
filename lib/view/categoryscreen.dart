import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterquizapp/provider/languageprovider.dart';
import 'package:flutterquizapp/provider/quizprovider.dart';
import 'package:flutterquizapp/ressource/strings.dart';
import 'package:flutterquizapp/viewmodel/quizmodel.dart';
import 'package:flutterquizapp/widget/buttons/defaultbutton.dart';
import 'package:flutterquizapp/widget/topbar.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    .getLanguageCode()]!["category_appbar_title"],
              ),
            ),
            Container(
              height: 400,
              width: 300,
              child: ListView.builder(
                  itemCount:
                      context.watch<QuizProvider>().quizModel.categoryCount,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: DefaultButton(
                          btnText: context
                              .read<QuizProvider>()
                              .categorylist[index]
                              .categoryName,
                          fontSize: 30,
                          onPressed: () async {
                            context
                                .read<QuizProvider>()
                                .quizModel
                                .categoryindex = index;
                            Navigator.pushNamed(context, "quizscreen");
                          }),
                    );
                  }),
            ),
            SizedBox(),
          ],
        ),
      ),
    );
  }
}
