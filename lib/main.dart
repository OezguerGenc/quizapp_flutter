import 'package:flutter/material.dart';
import 'package:flutterquizapp/provider/languageprovider.dart';
import 'package:flutterquizapp/provider/networkprovider.dart';
import 'package:flutterquizapp/provider/quizprovider.dart';
import 'package:flutterquizapp/provider/statsprovider.dart';
import 'package:flutterquizapp/provider/themeprovider.dart';
import 'package:flutterquizapp/provider/updateprovider.dart';
import 'package:flutterquizapp/view/categoryscreen.dart';
import 'package:flutterquizapp/view/mainscreen.dart';
import 'package:flutterquizapp/view/quizscreen.dart';
import 'package:flutterquizapp/view/statsscreen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => QuizProvider()),
      ChangeNotifierProvider(create: (_) => StatsProvider()),
      ChangeNotifierProvider(create: (_) => LanguageProvider()),
      ChangeNotifierProvider(create: (_) => NetworkProvider()),
      ChangeNotifierProvider(create: (_) => UpdateProvider()),
      ChangeNotifierProvider(create: (_) => ThemeProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'Flutter Quiz App',
      darkTheme: themeProvider.getTheme(),
      initialRoute: "/",
      routes: {
        "/": (context) => MainScreen(),
        "quizscreen": (context) => QuizScreen(),
        "categoryscreen": (context) => CategoryScreen(),
        "statsscreen": (context) => StatsScreen(),
      },
      theme: themeProvider.getTheme(),
    );
  }
}
