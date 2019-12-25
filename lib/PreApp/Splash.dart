import 'package:flutter/material.dart';
import 'package:aMazes/PreApp/Home.dart';
import 'package:aMazes/Globals/device.dart' as dev;
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:animator/animator.dart';
import 'package:aMazes/Globals/DataTypes.dart';
import 'dart:math';
import 'dart:ui';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

AudioCache player = AudioCache();
Future<AudioPlayer> control;
const bgm = 'india.mp3';

class Splash extends StatefulWidget {
  @override
  State createState() => new SplashState();
}

class SplashState extends State<Splash> {
  initSharedPreferences() async {
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.getStringList("localBoard") == null)
        prefs.setStringList("localBoard", []);
      if (prefs.getInt('playerColour') == null) prefs.setInt('playerColour', 0);
      if (prefs.getDouble('bgVolume') == null) prefs.setDouble('bgVolume', 0.5);
      if (prefs.getDouble('gameVolume') == null)
        prefs.setDouble('gameVolume', 0.5);

      List<Color> colours = [];
      for (int i = 0; i < 18; i++) colours.add(Colors.primaries[i][500]);
      colours.add(Colors.white);
      colours.add(Colors.black);
      GameSettings.playerColour = colours[prefs.getInt('playerColour')];
      GameSettings.bgVolume = prefs.getDouble('bgVolume');
      GameSettings.gameVolume = prefs.getDouble('gameVolume');
    });
  }

  @override
  void initState() {
    super.initState();
    initSharedPreferences();
    Future.delayed(Duration(seconds: 3), () {
      control = player.play(bgm, volume: GameSettings.bgVolume);
      control.then((controller) {
        controller.setReleaseMode(ReleaseMode.LOOP);
      });
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
    dev.screenHeight = MediaQuery.of(context).size.height;
    dev.screenWidth = MediaQuery.of(context).size.width;
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
                      image: DecorationImage(
                          image: AssetImage('assets/MazeCircle.png')),
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
