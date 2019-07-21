import 'package:flutter/material.dart';
import 'package:a_maze_ment/Globals/device.dart' as dev;

class Settings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SettingsPage();
}

class SettingsPage extends State<Settings> {
  int bgAudio = 100, gameAudio = 100;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).canvasColor,
        body: Column(children: [
          Container(
              child: Text(
            "Background Audio:",
          )),
          Container(
            child: Slider(
              value: bgAudio.toDouble(),
              label: '$bgAudio',
              onChanged: (double value) {
                setState(() {
                  bgAudio = value.round();
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
                  value: gameAudio.toDouble(),
                  label: '$gameAudio',
                  onChanged: (double value) {
                    setState(() {
                      gameAudio = value.round();
                    });
                  },
                  min: 0,
                  max: 100),
              padding: EdgeInsets.all(dev.screenWidth * 0.05))
        ], mainAxisAlignment: MainAxisAlignment.center));
  }
}
