import 'package:flutter/material.dart';
import 'package:flutterquizapp/widget/menubutton.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Hauptmenü', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 40.0),
              child: Text(
                'QuizApp',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 40, color: Colors.white),
              ),
            ),
            MenuButton(
              onPressed: () {
                print("object");
              },
            ),
            Container(
              width: 100,
              height: 100,
              child: Padding(
                padding: EdgeInsets.only(bottom: 40.0),
                child: Text(
                  'Made by\nÖzgür Genc',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
