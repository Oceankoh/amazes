import 'package:flutter/material.dart';
import 'package:a_maze_ment/PreApp/Splash.dart';

void main() => runApp(BaseApp());

class BaseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: Colors.white,
            accentColor: Colors.blueAccent,
            textTheme: TextTheme(
                headline: TextStyle(fontSize: 30),
                title: TextStyle(fontSize: 20),
                body1: TextStyle(fontSize: 10))),
        home: Splash());
  }
}
