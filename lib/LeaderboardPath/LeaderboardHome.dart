import 'package:a_maze_ment/LeaderboardPath/WorldBoard.dart';
import 'package:a_maze_ment/LeaderboardPath/DeviceBoard.dart';
import 'package:a_maze_ment/PreApp/Home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:a_maze_ment/Globals/device.dart' as dev;

class SelectLeaderboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LBOptionsState();
}

class LBOptionsState extends State<SelectLeaderboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Padding(
          padding: EdgeInsets.fromLTRB(0, dev.screenHeight / 4, 0, 0),
          child: Center(
              child: MaterialButton(
                  child: Text('Local Leaderboard',
                      style: Theme.of(context).textTheme.button),
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                  padding: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13))))),
      Center(
          child: MaterialButton(
              child: Text('Private Leaderboard',
                  style: Theme.of(context).textTheme.button),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
              padding: EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13)))),
      Padding(
          child: Center(
              child: MaterialButton(
                  child:
                      Text('Back', style: Theme.of(context).textTheme.button),
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                  padding: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13)))),
          padding: EdgeInsets.fromLTRB(0, dev.screenHeight / 4, 0, 0))
    ]));
  }
}
