import 'package:flutter/material.dart';
import 'package:a_maze_ment/PreApp/Home.dart';
import 'package:animator/animator.dart';
import 'dart:math';
import 'dart:ui';
import 'dart:async';

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
    return Scaffold(
        backgroundColor: Theme.of(context).canvasColor,
        body: Center(key: UniqueKey(), child: LoadAnimation()));
  }
}

class LoadAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(children: [
      Center(
          child: Animator(
              tween: Tween<double>(begin: 0, end: 2 * pi),
              duration: Duration(seconds: 2),
              repeats: 0,
              curve: Curves.easeInOutQuart,
              builder: (anim) => Transform.rotate(angle: anim.value, child: CircleLogo()))),
      Center(
          child: Text(
        'Loading...',
        style: TextStyle(fontSize: 40, color: Theme.of(context).primaryColor),
      ))
    ]));
  }
}

class CircleLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/MazeCircle.png');
  }
}
