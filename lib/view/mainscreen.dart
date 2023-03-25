import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterquizapp/model/dialogs.dart';
import 'package:flutterquizapp/provider/languageprovider.dart';
import 'package:flutterquizapp/provider/networkprovider.dart';
import 'package:flutterquizapp/provider/themeprovider.dart';
import 'package:flutterquizapp/provider/updateprovider.dart';
import 'package:flutterquizapp/ressource/strings.dart';
import 'package:flutterquizapp/widget/buttonmenu.dart';
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
        print("initState");
        await context.read<LanguageProvider>().loadLastSelectedLanguage();
        if (await context.read<UpdateProvider>().checkForUpdates(
            context.read<LanguageProvider>().getLanguageCode().toUpperCase())) {
          await context.read<UpdateProvider>().initUpdateText(
              context.read<LanguageProvider>().getLanguageCode());

          context.read<UpdateProvider>().activateUpdateAvailable();

          Dialogs().openUpdateDialog(context);
        } else {
          context.read<UpdateProvider>().initContentVersion();
        }
      } catch (e) {
        Dialogs().openErrorDialog(context, e.toString());
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
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).hintColor
            ],
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
                    context.watch<UpdateProvider>().getUpdateAvailable()
                        ? SizedBox(
                            width: 50,
                            child: IconButton(
                              icon: Icon(
                                Icons.file_download,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Dialogs().openUpdateDialog(context);
                              },
                            ),
                          )
                        : context.read<ThemeProvider>().isDarkMode
                            ? SizedBox(
                                width: 50,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.light_mode,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    context.read<ThemeProvider>().toggleTheme();
                                  },
                                ),
                              )
                            : SizedBox(
                                width: 50,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.dark_mode,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    context.read<ThemeProvider>().toggleTheme();
                                  },
                                ),
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
                          Dialogs().openLanguageSelectionDialog(context, () {
                            setState(() {});
                          });
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
                    ButtonMenu(),
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
                              context
                                  .watch<UpdateProvider>()
                                  .getContentVersion(),
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
}
