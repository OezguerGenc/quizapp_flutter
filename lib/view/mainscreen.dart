import 'package:flutter/material.dart';
import 'package:flutterquizapp/model/dialogs.dart';
import 'package:flutterquizapp/provider/languageprovider.dart';
import 'package:flutterquizapp/provider/updateprovider.dart';
import 'package:flutterquizapp/ressource/strings.dart';
import 'package:flutterquizapp/widget/buttonmenu.dart';
import 'package:flutterquizapp/widget/menubottom.dart';
import 'package:flutterquizapp/widget/screentitle.dart';
import 'package:flutterquizapp/widget/topbar.dart';
import 'package:provider/provider.dart';

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
              const MenuTopBar(),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: ScreenTitle(
                          titletext: AppStrings.language[context
                              .read<LanguageProvider>()
                              .getLanguageCode()]!["mainmenu_title"],
                        )),
                    const ButtonMenu(),
                    MenuBottom(
                        madeByText: AppStrings.language[context
                            .read<LanguageProvider>()
                            .getLanguageCode()]!["mainmenu_madeby"],
                        contentVerrsionText:
                            context.watch<UpdateProvider>().getContentVersion())
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
