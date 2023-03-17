import 'package:flutter/material.dart';
import 'package:flutterquizapp/provider/languageprovider.dart';
import 'package:flutterquizapp/ressource/strings.dart';
import 'package:provider/provider.dart';

class NextButton extends StatelessWidget {
  final VoidCallback onPressed;
  const NextButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 100),
      child: Container(
        width: MediaQuery.of(context).size.width - 50,
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
                .getLanguageCode()]!["quiz_nextquestionbtn"],
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
      ),
    );
  }
}
