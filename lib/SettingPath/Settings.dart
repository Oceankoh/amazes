import 'package:flutter/material.dart';
import 'package:a_maze_ment/PreApp/Splash.dart';
import 'package:a_maze_ment/Globals/device.dart' as dev;

class Settings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SettingsPage();
}

class SettingsPage extends State<Settings> {
  double bgAudio = dev.bgVolume * 100, gameAudio = dev.gameVolume * 100;
  @override
  Widget build(BuildContext context) {
    int bgLabel = bgAudio.round();
    int gameLabel = gameAudio.round();
    return Scaffold(
        backgroundColor: Theme.of(context).canvasColor,
        body: Column(children: [
          Container(
              child: Text(
            "Background Audio:",
          )),
          Container(
            child: Slider(
              value: bgAudio,
              label: '$bgLabel',
              onChanged: (double value) {
                setState(() {
                  bgAudio = value;
                  dev.bgVolume = bgAudio / 100;
                  control.then((controller){
                      controller.setVolume(dev.bgVolume);
                  });
                });
              },
              min: 0,
              max: 100,
              divisions: 100,
            ),
            padding: EdgeInsets.all(dev.screenWidth * 0.05),
          ),
          Container(
              child: Text(
                "Game Audio:",
              ),
              padding: EdgeInsets.only(top: dev.screenHeight * 0.1)),
          Container(
              child: Slider(
                  value: gameAudio,
                  label: '$gameLabel',
                  onChanged: (double value) {
                    setState(() {
                      gameAudio = value;
                      dev.gameVolume = gameAudio / 100;
                    });
                  },
                  min: 0,
                  max: 100,
                  divisions: 100),
              padding: EdgeInsets.all(dev.screenWidth * 0.05))
        ], mainAxisAlignment: MainAxisAlignment.center));
  }
}
