import 'package:aMazes/Globals/DataTypes.dart';
import 'package:flutter/material.dart';
import 'package:aMazes/Globals/device.dart' as dev;
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SettingsPage();
}

class SettingsPage extends State<Settings> with WidgetsBindingObserver {
  double bgAudio = GameSettings.bgVolume * 100,
      gameAudio = GameSettings.gameVolume * 100;
  SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      GlobalAudioPlayer.backgroundAudio.then((controller) {
        controller.pause();
      });
      GlobalAudioPlayer.winAudio.then((controller) {
        controller.pause();
      });
    }
    if (state == AppLifecycleState.resumed) {
      GlobalAudioPlayer.backgroundAudio.then((controller) {
        controller.resume();
      });
      GlobalAudioPlayer.winAudio.then((controller) {
        controller.resume();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    int bgLabel = bgAudio.round();
    int gameLabel = gameAudio.round();
    List<Color> colours = [];
    for (int i = 0; i < 18; i++) colours.add(Colors.primaries[i][500]);
    colours.add(Colors.white);
    colours.add(Colors.black);
    initSharedPrefs();
    return Scaffold(
        backgroundColor: Theme.of(context).canvasColor,
        body: Column(children: [
          Container(
              child: Text(
                "Background Audio:",
              ),
              padding: EdgeInsets.only(top: dev.screenHeight * 0.05)),
          Container(
            child: Slider(
              value: bgAudio,
              label: '$bgLabel',
              onChanged: (double value) {
                setState(() {
                  bgAudio = value;
                  GameSettings.bgVolume = bgAudio / 100;
                  GlobalAudioPlayer.backgroundAudio.then((controller) {
                    controller.setVolume(GameSettings.bgVolume);
                  });
                });
              },
              min: 0,
              max: 100,
              divisions: 100,
            ),
            padding: EdgeInsets.all(dev.screenWidth * 0.02),
          ),
          Container(
              child: Text("Game Audio:"),
              padding: EdgeInsets.only(top: dev.screenHeight * 0.02)),
          Container(
              child: Slider(
                  value: gameAudio,
                  label: '$gameLabel',
                  onChanged: (double value) {
                    setState(() {
                      gameAudio = value;
                      GameSettings.gameVolume = gameAudio / 100;
                    });
                  },
                  min: 0,
                  max: 100,
                  divisions: 100),
              padding: EdgeInsets.all(dev.screenWidth * 0.02)),
          Container(
              child: Text("Player Colour"),
              padding: EdgeInsets.only(top: dev.screenHeight * 0.05)),
          Container(
            child: GridView.count(
              crossAxisCount: 5,
              children: List.generate(20, (index) {
                return MaterialButton(
                  color: colours[index],
                  onPressed: () {
                    prefs.setInt('playerColour', index);
                    GameSettings.playerColour = colours[index];
                  },
                );
              }),
            ),
            height: dev.screenHeight / 2,
          )
        ], mainAxisAlignment: MainAxisAlignment.center));
  }

  void initSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }
}
