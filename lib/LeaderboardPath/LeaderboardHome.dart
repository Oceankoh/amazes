import 'package:aMazes/LeaderboardPath/UniversalBoard.dart';
import 'package:aMazes/PreApp/Home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aMazes/Globals/device.dart' as dev;
import 'package:aMazes/Globals/DataTypes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectLeaderboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LBOptionsState();
}

class LBOptionsState extends State<SelectLeaderboard>
    with WidgetsBindingObserver {
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
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Padding(
          padding: EdgeInsets.fromLTRB(0, dev.screenHeight / 4, 0, 0),
          child: Center(
              child: MaterialButton(
                  child: Text('Local Leaderboard',
                      style: Theme.of(context).textTheme.button),
                  onPressed: () {
                    //load the leaderboard view
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
                    //return to the home page
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                  padding: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13)))),
          padding: EdgeInsets.fromLTRB(0, dev.screenHeight / 4, 0, 0))
    ]));
  }

  //Viewing online leaderboard requires async transaction
  joinLeaderboard() async {
    //asynchronous operation to access stored credentials
    await SharedPreferences.getInstance().then((prefs) async {
      //access id of previously joined leaderboard if exists
      String onlineBoardID = prefs.getString("onlineBoardID");
      //user has previously joined board
      if (onlineBoardID != null) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    UniversalBoard(isLocal: false, boardId: onlineBoardID)));
      } else {
        //user does not have a previously joined board
        print("boardID is null");
        //Object to control user input from text field
        final leaderboardController = TextEditingController();
        //show options to join or create new online leaderboard
        await showDialog(
            context: context,
            //create dialog popup with necessary options
            builder: (BuildContext context) {
              return SimpleDialog(
                  title: Text("Join Online Leaderboard",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.body1),
                  contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  children: [
                    TextField(
                        controller: leaderboardController,
                        maxLength: 20,
                        autocorrect: false),
                    MaterialButton(
                        child: Text("Join",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.button),
                        onPressed: () {
                          //save the boardID entered by the user auto-join on next viewing
                          prefs.setString(
                              "onlineBoardID", leaderboardController.text);
                          //load the leaderboard view
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UniversalBoard(
                                      isLocal: false,
                                      boardId: leaderboardController.text)));
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    MaterialButton(
                        child: Text("Create New",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.button),
                        //create and initialise instance of online leaderboard
                        onPressed: () {
                          //empty map used to initialise database
                          Map<String, dynamic> newMap = {"Scores": []};
                          //create new board instance
                          Firestore.instance
                              .collection("Leaderboard")
                              .add(newMap)
                              .then((documentReference) {
                                print(documentReference.documentID);
                            //store the boardID for auto-login on next viewing
                            prefs.setString(
                                "onlineBoardID", documentReference.documentID);
                            //load the leaderboard view
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UniversalBoard(
                                        isLocal: false,
                                        boardId:
                                            documentReference.documentID)));
                          });
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)))
                  ],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)));
            });
      }
    });
  }
}
