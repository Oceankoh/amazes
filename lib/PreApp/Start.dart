import 'package:flutter/material.dart';
import 'package:a_maze_ment/PreApp/Splash.dart';
import 'dart:ui';

void main() => runApp(BaseApp());

class BaseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: Colors.white,
            buttonColor: Color(0x00FFFFFF),
            accentColor: Color.fromRGBO(51, 51, 204, 1),
            canvasColor: Color(0xFF263238),
            accentTextTheme: TextTheme(body2: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
            textTheme: TextTheme(
                headline: TextStyle(fontSize: 50, color: Colors.white,fontWeight: FontWeight.bold),
                title: TextStyle(fontSize: 30, color: Colors.white),
                caption: TextStyle(fontSize: 20, color: Colors.white),
                body1: TextStyle(fontSize: 10, color: Colors.white),
                body2: TextStyle(fontSize: 5, color: Colors.white),
                button: TextStyle(fontSize: 20, color: Colors.white)),
            buttonTheme: ButtonThemeData(height: 50, minWidth: 200, padding: EdgeInsets.all(10),buttonColor: Colors.transparent)),
        home: Splash());
  }
}
