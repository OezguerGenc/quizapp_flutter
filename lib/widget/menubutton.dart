import 'package:flutter/material.dart';
import 'package:flutterquizapp/provider/languageprovider.dart';
import 'package:flutterquizapp/ressource/strings.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MenuButton extends StatelessWidget {
  final String btnText;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  const MenuButton(
      {Key? key,
      required this.btnText,
      this.width = 300,
      this.height = 100,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
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
          btnText,
          style: GoogleFonts.cabinSketch(
            fontSize: 50,
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
