import 'package:flutter/material.dart';
import 'package:flutterquizapp/provider/languageprovider.dart';
import 'package:flutterquizapp/ressource/strings.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MenuButton extends StatefulWidget {
  final String btnText;
  final double? fontSize;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  final bool animated;
  const MenuButton(
      {Key? key,
      required this.btnText,
      this.fontSize = 40,
      this.width = 300,
      this.height = 100,
      this.animated = false,
      required this.onPressed})
      : super(key: key);

  @override
  State<MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 50.0, end: 60.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.blue, Colors.redAccent],
        ),
      ),
      child: ElevatedButton(
        onPressed: widget.onPressed,
        child: widget.animated
            ? AnimatedBuilder(
                animation: _animation,
                builder: (BuildContext context, Widget? child) {
                  return Text(
                    widget.btnText,
                    style: GoogleFonts.cabinSketch(
                      fontSize: _animation.value,
                      color: Colors.white,
                    ),
                  );
                },
              )
            : Text(
                widget.btnText,
                style: GoogleFonts.cabinSketch(
                  fontSize: widget.fontSize,
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
