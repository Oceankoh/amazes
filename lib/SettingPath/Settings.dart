import 'package:flutter/material.dart';
import 'package:aMazes/PreApp/Splash.dart';
import 'package:aMazes/Globals/device.dart' as dev;

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
    List<Color> colors = [];
    for(int i =0; i<18; i++)
      colors.add(Colors.primaries[i][500]);
    colors.add(Colors.white);
    colors.add(Colors.black);
    return Scaffold(
        backgroundColor: Theme.of(context).canvasColor,
        body: Column(children: [
          Container(
              child: Text(
            "Background Audio:",
          ),padding: EdgeInsets.only(top: dev.screenHeight*0.05)),
          Container(
            child: Slider(
              value: bgAudio,
              label: '$bgLabel',
              onChanged: (double value) {
                setState(() {
                  bgAudio = value;
                  dev.bgVolume = bgAudio / 100;
                  control.then((controller) {
                    controller.setVolume(dev.bgVolume);
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
                      dev.gameVolume = gameAudio / 100;
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
                color: colors[index],
                onPressed: () {
                  dev.playerColor=index;
                },
              );
            }),
          ),height: dev.screenHeight/2,)
        ], mainAxisAlignment: MainAxisAlignment.center));
  }
}
