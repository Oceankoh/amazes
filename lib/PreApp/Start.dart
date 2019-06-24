import 'package:flutter/material.dart';
import 'package:a_maze_ment/PreApp/Splash.dart';
import 'dart:ui';

void main() => runApp(BaseApp());

class BaseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: Colors.white,
            accentColor: Color.fromRGBO(51, 51, 204, 1),
            canvasColor: Color(0xff576574),
            textTheme: TextTheme(
                headline: TextStyle(fontSize: 30),
                title: TextStyle(fontSize: 20),
                body1: TextStyle(fontSize: 10),
                button: TextStyle(fontSize: 20)),
            buttonTheme: ButtonThemeData(height: 50, minWidth: 200, padding: EdgeInsets.all(10))),
        home: Splash());
  }
}
