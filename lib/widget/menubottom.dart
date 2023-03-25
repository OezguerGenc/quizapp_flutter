import 'package:flutter/material.dart';

class MenuBottom extends StatelessWidget {
  final String madeByText;
  final String contentVerrsionText;
  final Color textColor;
  const MenuBottom(
      {super.key,
      required this.madeByText,
      required this.contentVerrsionText,
      this.textColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 100,
          height: 100,
          child: Text(
            madeByText,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor,
            ),
          ),
        ),
        SizedBox(
          width: 200,
          height: 50,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              contentVerrsionText,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
