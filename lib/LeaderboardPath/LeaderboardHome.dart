import 'package:aMazes/LeaderboardPath/UniversalBoard.dart';
import 'package:aMazes/PreApp/Home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aMazes/Globals/device.dart' as dev;
import 'package:shared_preferences/shared_preferences.dart';

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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                UniversalBoard(isLocal: true)));
                  },
                  padding: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13))))),
      Center(
          child: MaterialButton(
              child: Text('Private Leaderboard',
                  style: Theme.of(context).textTheme.button),
              onPressed: () {
                joinLeaderboard();
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

  joinLeaderboard() async {
    await SharedPreferences.getInstance().then((prefs) async {
      String onlineBoardID = prefs.getString("onlineBoardID");
      if (onlineBoardID != null) {
        prefs.setString("onlineBoardID", null);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    UniversalBoard(isLocal: false, boardId: onlineBoardID)));
      } else {
        print("boardID is null");
        final leaderboardController = TextEditingController();
        await showDialog(
            context: context,
            builder: (BuildContext context) {
              return SimpleDialog(
                  title: Text("Join Leaderboard",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.body1),
                  contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  children: [
                    TextField(
                        controller: leaderboardController,
                        maxLength: 20,
                        autocorrect: false),
                    MaterialButton(
                        child: Text("Join Leaderboard",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.button),
                        onPressed: () {
                          prefs.setString(
                              "onlineBoardID", leaderboardController.text);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UniversalBoard(
                                      isLocal: false,
                                      boardId: leaderboardController.text)));
                        }),
                    MaterialButton(
                        child: Text("Create Leaderboard",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.button),
                        onPressed: () {})
                  ],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)));
            });
      }
    });
  }
}
