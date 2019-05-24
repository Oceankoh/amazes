import 'package:flutter/material.dart';
import 'package:a_maze_ment/PreApp/Home.dart';

import 'dart:async';

void main() => runApp(BaseApp());

class BaseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Splash());
  }
}

class Splash extends StatefulWidget {
  @override
  State createState() => new SplashState();
}

class SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, new MaterialPageRoute(builder: (context) => HomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}
