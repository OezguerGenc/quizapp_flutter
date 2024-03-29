import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DefaultButton extends StatelessWidget {
  final String btnText;
  final double fontSize;
  final VoidCallback onPressed;
  final double width;
  const DefaultButton(
      {Key? key,
      required this.btnText,
      this.fontSize = 40,
      this.width = 0,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: Container(
        width: width == 0 ? MediaQuery.of(context).size.width - 50 : width,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).hintColor,
              Theme.of(context).primaryColor
            ],
          ),
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text(
            btnText,
            style: TextStyle(
              fontSize: fontSize,
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
