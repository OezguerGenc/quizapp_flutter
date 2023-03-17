import 'package:flutter/material.dart';
import 'package:flutterquizapp/provider/languageprovider.dart';
import 'package:flutterquizapp/ressource/strings.dart';
import 'package:provider/provider.dart';

class MenuButton extends StatelessWidget {
  final VoidCallback onPressed;
  const MenuButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.blue, Colors.redAccent],
        ),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          AppStrings.language[context
              .read<LanguageProvider>()
              .getLanguageCode()]!["mainmenu_startbtn"],
          style: TextStyle(
            fontSize: 40,
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          onPrimary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
