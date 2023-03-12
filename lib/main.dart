import 'package:flutter/material.dart';
import 'package:flutterquizapp/provider/quizprovider.dart';
import 'package:flutterquizapp/view/mainscreen.dart';
import 'package:flutterquizapp/view/quizscreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => QuizProvider())],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Quiz App',
      initialRoute: "/",
      routes: {
        "/": (context) => MainScreen(),
        "quizscreen": (context) => QuizScreen()
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
