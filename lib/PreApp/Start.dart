import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:aMazes/PreApp/Splash.dart';
import 'dart:ui';

void main() => runApp(BaseApp());

class BaseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //ensure device is always in portrait mode
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
        theme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: Colors.white,
            buttonColor: Color(0x00FFFFFF),
            primaryColorDark: Color(0xFF000A12),
            accentColor: Color(0xFF003C8F),
            canvasColor: Color(0xFF263238),
            accentTextTheme: TextTheme(
                body2: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
            textTheme: TextTheme(
                headline: TextStyle(
                    fontSize: 50,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                title: TextStyle(fontSize: 25, color: Colors.black),
                caption: TextStyle(fontSize: 20, color: Colors.white),
                subhead: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                body1: TextStyle(fontSize: 17, color: Colors.white),
                body2: TextStyle(fontSize: 15, color: Colors.white),
                button: TextStyle(fontSize: 20, color: Colors.white, shadows: [
                  Shadow(
                      color: Color(0xFF000A12),
                      offset: Offset(5, 5),
                      blurRadius: 10)
                ])),
            buttonTheme: ButtonThemeData(
                height: 50,
                minWidth: 200,
                padding: EdgeInsets.all(10),
                buttonColor: Colors.transparent)),
        home: Splash());
  }
}
