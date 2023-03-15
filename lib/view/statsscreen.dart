import 'package:flutter/material.dart';
import 'package:flutterquizapp/widget/defaultbutton.dart';
import 'package:flutterquizapp/widget/statsoverview.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Statistik",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(),
          StatsOverView(),
          DefaultButton(
              btnText: "Hauptmenü",
              onPressed: () {
                Navigator.popAndPushNamed(context, "/");
              })
        ],
      )),
    );
  }
}
