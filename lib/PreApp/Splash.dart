import 'package:flutter/material.dart';
import 'package:aMazes/PreApp/Home.dart';
import 'package:aMazes/Globals/device.dart' as dev;
import 'package:animator/animator.dart';
import 'package:aMazes/Globals/DataTypes.dart';
import 'dart:math';
import 'dart:ui';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  @override
  State createState() => new SplashState();
}

class SplashState extends State<Splash> with WidgetsBindingObserver {
  @override
  void initState() {
    //call original init state functions
    super.initState();
    //add listener for change in state of app lifecycle
    WidgetsBinding.instance.addObserver(this);
    //initialise data stored in Sharedpreferences
    initSharedPreferences();
    //load the audio assets into the Audio Cache
    GlobalAudioPlayer.load();
    //Fixed delay to account for runtime of operations
    Future.delayed(Duration(seconds: 3), () {
      //Play background audio
      GlobalAudioPlayer.playBgAudio();
      //Navigate to the home screen of the app
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    });
  }

  @override
  void dispose() {
    //call original dispose functions
    super.dispose();
    //remove the listener for change in state of app lifecycle
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    //check if app is in paused state
    if (state == AppLifecycleState.paused) {
      //pause the background audio
      GlobalAudioPlayer.backgroundAudio.then((controller) {
        controller.pause();
      });
      //stop the win audio, since the entire clip is too short and insignificant to pause
      GlobalAudioPlayer.winAudio.then((controller) {
        controller.release();
      });
    }
    //check if the app is in the resumed state
    if (state == AppLifecycleState.resumed) {
      //resume the background audio
      GlobalAudioPlayer.backgroundAudio.then((controller) {
        controller.resume();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //return a loading animation
    return Scaffold(
        backgroundColor: Theme.of(context).canvasColor,
        body: Center(key: UniqueKey(), child: LoadAnimation()));
  }

  //method to initialise data stored in the Sharedpreferences
  initSharedPreferences() async {
    //retrieve instance of Sharedpreferences
    SharedPreferences.getInstance().then((prefs) {
      //if variable did not exist previously, create it and initialise to default value
      if (prefs.getStringList("localBoard") == null)
        prefs.setStringList("localBoard", []);
      if (prefs.getInt('playerColour') == null) prefs.setInt('playerColour', 0);
      if (prefs.getDouble('bgVolume') == null) prefs.setDouble('bgVolume', 0.5);
      if (prefs.getDouble('gameVolume') == null)
        prefs.setDouble('gameVolume', 0.5);

      //create the color palette which the player can choose their player color from
      List<Color> colours = [];
      for (int i = 0; i < 18; i++) colours.add(Colors.primaries[i][500]);
      colours.add(Colors.white);
      colours.add(Colors.black);

      //implement default/previous settings configured on last open
      GameSettings.playerColour = colours[prefs.getInt('playerColour')];
      GameSettings.bgVolume = prefs.getDouble('bgVolume');
      GameSettings.gameVolume = prefs.getDouble('gameVolume');
    });
  }
}

class LoadAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //retrieve values of the device screen used to build the GUIs of the app
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
