import 'package:flutter/material.dart';
import 'package:a_maze_ment/PreApp/Home.dart';
import 'package:a_maze_ment/Globals/device.dart' as dev;
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/services.dart';
import 'package:animator/animator.dart';
import 'dart:math';
import 'dart:ui';
import 'dart:async';

AudioCache player = AudioCache();
Future<AudioPlayer> control;
const bgm = 'Modified2.mp3';

class Splash extends StatefulWidget {
  @override
  State createState() => new SplashState();
}

class SplashState extends State<Splash> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => HomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).canvasColor,
        body: Center(key: UniqueKey(), child: LoadAnimation()));
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }
}

class LoadAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    dev.screenHeight = MediaQuery.of(context).size.height;
    dev.screenWidth = MediaQuery.of(context).size.width;
    dev.gameVolume = 0.5;
    dev.bgVolume = 0.5;
    control = player.play(bgm,volume: dev.bgVolume);
    return Container(
        child: Center(
            child: Column(children: [
      Container(
          child: Animator(
              tween: Tween<double>(begin: 0, end: 2 * pi),
              duration: Duration(seconds: 2),
              repeats: 0,
              curve: Curves.easeInOutQuart,
              builder: (anim) => Transform.rotate(
                  angle: anim.value,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage('assets/MazeCircle.png')),
                      shape: BoxShape.circle,
                    ),
                    width: dev.screenWidth * 0.2,
                    height: dev.screenHeight * 0.2,
                  )))),
      Text(
        'LOADING',
        style: TextStyle(fontSize: 40, color: Theme.of(context).primaryColor),
      ),
    ], mainAxisAlignment: MainAxisAlignment.center)));
  }
}
