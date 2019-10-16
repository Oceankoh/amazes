import 'package:a_maze_ment/LeaderboardPath/WorldBoard.dart';
import 'package:a_maze_ment/LeaderboardPath/DeviceBoard.dart';
import 'package:a_maze_ment/PreApp/Home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectLeaderboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LBOptionsState();
}

class LBOptionsState extends State<SelectLeaderboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Center(
          child: MaterialButton(
              child: Text('Local Leaderboard',
                  style: Theme.of(context).textTheme.button),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LocalBoard()));
              })),
      Center(
          child: MaterialButton(
              child: Text('Private Leaderboard',
                  style: Theme.of(context).textTheme.button),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => PrivateBoard()));
              })),
      Padding(   
          child: Center(
              child: MaterialButton(
                  child:
                      Text('Back', style: Theme.of(context).textTheme.button),
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  })),
          padding: EdgeInsets.fromLTRB(0, 20, 0, 0))
    ]));
  }
}
