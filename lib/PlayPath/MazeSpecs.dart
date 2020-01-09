import 'package:flutter/material.dart';
import 'package:aMazes/Globals/device.dart' as dev;
import 'package:aMazes/Globals/DataTypes.dart';
import 'package:aMazes/PlayPath/Maze.dart';

//Global Variable mazeSize to be set by user, defaults to 15
int mazeSize = 15;

class Sizing extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => Size();
}

class Size extends State<Sizing> with WidgetsBindingObserver {
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
        controller.release();
      });
    }
    if (state == AppLifecycleState.resumed) {
      GlobalAudioPlayer.backgroundAudio.then((controller) {
        controller.resume();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).canvasColor,
        body: Center(
            child: Column(children: [
          Container(
            child:
                Text("Maze Size", style: Theme.of(context).textTheme.headline),
          ),
          Container(
              child: Text(
                '$mazeSize',
                style: Theme.of(context).textTheme.caption,
                textAlign: TextAlign.center,
              ),
              padding: EdgeInsets.only(top: dev.screenWidth * 0.2)),
          Row(
            children: [
              MaterialButton(
                  onPressed: () {
                    //rebuild the GUI after decrementing the maze size by 1
                    setState(() {
                      if (mazeSize > 2) mazeSize--;
                    });
                  },
                  child: Icon(Icons.remove),
                  shape: CircleBorder(),
                  minWidth: dev.screenWidth * 0.1),
              Slider(
                  value: mazeSize.toDouble(),
                  onChanged: (double value) {
                    //rebuild the GUI setting the maze size to the slider value
                    setState(() {
                      mazeSize = value.round();
                    });
                  },
                  min: 2,
                  max: 30),
              MaterialButton(
                  onPressed: () {
                    setState(() {
                      //rebuild the GUI after incrementing the maze size by 1
                      if (mazeSize < 30) mazeSize++;
                    });
                  },
                  child: Icon(Icons.add),
                  shape: CircleBorder(),
                  minWidth: dev.screenWidth * 0.1)
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          Container(height: dev.screenWidth * 0.1),
          MaterialButton(
              child: Text('Confirm', style: Theme.of(context).textTheme.button),
              onPressed: () {
                //Generate the maze based on the maze size specified by the user
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GenerateMaze(side: mazeSize)));
              })
        ], mainAxisAlignment: MainAxisAlignment.center)));
  }
}
