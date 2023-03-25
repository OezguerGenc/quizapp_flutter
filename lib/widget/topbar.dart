import 'package:flutter/material.dart';
import 'package:flutterquizapp/model/dialogs.dart';
import 'package:flutterquizapp/provider/languageprovider.dart';
import 'package:flutterquizapp/provider/themeprovider.dart';
import 'package:flutterquizapp/provider/updateprovider.dart';
import 'package:flutterquizapp/ressource/strings.dart';
import 'package:provider/provider.dart';

class MenuTopBar extends StatefulWidget {
  const MenuTopBar({super.key});

  @override
  State<MenuTopBar> createState() => _MenuTopBarState();
}

class _MenuTopBarState extends State<MenuTopBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          context.watch<UpdateProvider>().getUpdateAvailable()
              ? SizedBox(
                  width: 50,
                  child: IconButton(
                    icon: const Icon(
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
                        icon: const Icon(
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
                        icon: const Icon(
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
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            width: 50,
            child: IconButton(
              icon: const Icon(
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
    );
  }
}

class TopBar extends StatefulWidget {
  final String title;
  final Color textcolor;
  const TopBar({super.key, required this.title, this.textcolor = Colors.white});

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: 50,
          ),
          SizedBox(
            child: Text(widget.title,
                style: TextStyle(
                    color: widget.textcolor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold)),
          ),
          const SizedBox(
            width: 50,
          ),
        ],
      ),
    );
  }
}
