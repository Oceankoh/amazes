import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:aMazes/LeaderboardPath/LeaderboardHome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aMazes/Globals/device.dart' as dev;
import 'package:aMazes/Globals/DataTypes.dart';

class UniversalBoard extends StatefulWidget {
  //id of online leaderboard
  final String boardId;

  //boolean to show local or online leaderboard
  final bool isLocal;

  //constructor to initialise variables
  UniversalBoard({Key key, this.boardId, this.isLocal}) : super(key: key);

  @override
  State createState() => UniversalLeaderboard(boardId, isLocal);
}

class UniversalLeaderboard extends State<UniversalBoard>
    with WidgetsBindingObserver {
  String onlineBoardID;
  bool isLocal;
  List<dynamic> displayBoard;
  final _key = GlobalKey<ScaffoldState>();

  //constructor to initialise state
  UniversalLeaderboard(this.onlineBoardID, this.isLocal);

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
        key: _key,
        body: CustomScrollView(shrinkWrap: true, slivers: <Widget>[
          SliverAppBar(
              pinned: true,
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () async {
                    await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return dialogWidget();
                        });
                  },
                  alignment: Alignment.centerRight,
                ),
              ],
              floating: false,
              expandedHeight: dev.screenHeight / 6,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text("Leaderboard",
                    style: Theme.of(context).textTheme.title,
                    textAlign: TextAlign.center),
              )),
          scoreList()
        ]));
  }

  //List of leaderboard scores
  Widget scoreList() {
    //populate list with data
    if (isLocal) {
      //retrieve scores stored locally
      getLocalScores();
    } else {
      //retrieve scores stored online
      getOnlineScores();
      print('test');
    }
    //since UI builds faster than data is retrieved, check if data is ready before trying to display it
    if (displayBoard != null) {
      //displayed loaded data in a list
      return SliverFixedExtentList(
          itemExtent: 50,
          //builder to iterate through entire data set and generate a widget for each
          delegate: SliverChildBuilderDelegate((context, index) {
            //template of an individual score entry widget
            return Row(
              children: [
                Padding(
                    child: Container(
                        child: Text((index + 1).toString(),
                            style: Theme.of(context).textTheme.body1),
                        width: dev.screenWidth / 10),
                    padding: EdgeInsets.all(10)),
                Padding(
                  child: Container(
                      child: Text(jsonDecode(displayBoard[index])["username"],
                          style: Theme.of(context).textTheme.body1),
                      width: dev.screenWidth / 2),
                  padding: EdgeInsets.all(10),
                ),
                Padding(
                    child: Container(
                        child: Text(
                            jsonDecode(displayBoard[index])["score"].toString(),
                            style: Theme.of(context).textTheme.body1),
                        width: dev.screenWidth / 5),
                    padding: EdgeInsets.all(10))
              ],
            );
          }, childCount: displayBoard.length));
    } else {
      //no data loaded yet hence return default screen to try again
      return noData();
    }
  }

  //default screen in case of no data or still loading
  Widget noData() {
    return SliverFixedExtentList(
        itemExtent: dev.screenHeight * 3 / 4,
        delegate: SliverChildBuilderDelegate(
            (context, index) => Column(
                  children: [
                    Padding(
                        child: Text(
                            "Unable to get data. Click refresh to try again.",
                            style: Theme.of(context).textTheme.body1,
                            textAlign: TextAlign.center),
                        padding: EdgeInsets.fromLTRB(
                            10, dev.screenHeight / 4, 0, dev.screenHeight / 4)),
                    MaterialButton(
                        child: Text("Refresh",
                            style: Theme.of(context).textTheme.button),
                        onPressed: () {
                          //refresh state to recheck if data is available
                          setState(() {});
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)))
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
            childCount: 1));
  }

  //menu for leaderboard controls
  Widget dialogWidget() {
    //check if leaderboard displayed is local or online
    if (isLocal) {
      //display set of controls for local leaderboard
      return SimpleDialog(
        children: [
          MaterialButton(
              child: Text("Clear Leaderboard",
                  style: Theme.of(context).textTheme.button),
              onPressed: () async {
                await SharedPreferences.getInstance().then((prefs) {
                  prefs.setStringList("localBoard", []);
                  setState(() {});
                });
              })
        ],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      );
    } else {
      //display set of controls for online leaderboard
      return SimpleDialog(children: <Widget>[
        MaterialButton(
            child: Text("Invite Friends",
                style: Theme.of(context).textTheme.button),
            onPressed: () async {
              await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    //dialog popup to show user current online leaderboard id
                    return SimpleDialog(
                      title: Text(
                          "Get your friends to enter this ID to join your leaderboard",
                          style: Theme.of(context).textTheme.caption,
                          textAlign: TextAlign.center),
                      contentPadding: EdgeInsets.fromLTRB(24, 6, 24, 6),
                      children: [
                        Row(
                          children: <Widget>[
                            Container(
                                child: Text(
                                  onlineBoardID,
                                  style: Theme.of(context).textTheme.body2,
                                  textAlign: TextAlign.center,
                                ),
                                width: 210),
                            IconButton(
                                icon: Icon(Icons.content_copy),
                                onPressed: () {
                                  //copy leaderboard ID to clipboard
                                  Clipboard.setData(
                                      ClipboardData(text: onlineBoardID));
                                })
                          ],
                        )
                      ],
                    );
                  });
            }),
        MaterialButton(
            child: Text("Leave Leaderboard",
                style: Theme.of(context).textTheme.button),
            onPressed: () async {
              //clear boardID stored and go back to leaderboard home page
              await SharedPreferences.getInstance().then((prefs) {
                prefs.setString("onlineBoardID", null);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SelectLeaderboard()));
              });
            })
      ], shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)));
    }
  }

  //retrieve data from online database
  getOnlineScores() async {
    //attempt to read data from database
    try {
      Firestore.instance
          .collection("Leaderboard")
          .document(onlineBoardID)
          .get()
          .then((documentSnapshot) {
        //data is read and stored in displayBoard variable
        displayBoard = documentSnapshot["Scores"];
        if (displayBoard.length >= 2) {
          //sort the scores before displaying
          displayBoard.sort((a, b) =>
              jsonDecode(b)["score"].compareTo(jsonDecode(a)["score"]));
        }
      });
    } catch (stacktrace) {
      print(stacktrace.toString());
    }
  }

  //retrieve data from local database
  getLocalScores() async {
    //read data from local storage
    SharedPreferences.getInstance().then((prefs) {
      //data is read and stored in displayBoard variable
      displayBoard = prefs.getStringList("localBoard");
    });
  }
}
