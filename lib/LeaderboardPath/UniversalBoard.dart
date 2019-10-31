import 'dart:convert';
import 'package:aMazes/LeaderboardPath/LeaderboardHome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aMazes/Globals/device.dart' as dev;

class UniversalBoard extends StatefulWidget {
  final String boardId;
  final bool isLocal;

  UniversalBoard({Key key, this.boardId, this.isLocal}) : super(key: key);

  @override
  State createState() => UniversalLeaderboard(boardId, isLocal);
}

class UniversalLeaderboard extends State<UniversalBoard> {
  String onlineBoardID;
  bool isLocal;
  List<dynamic> displayBoard;

  UniversalLeaderboard(this.onlineBoardID, this.isLocal);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(shrinkWrap: true, slivers: <Widget>[
      SliverAppBar(
          pinned: true,
          title: Row(children: [
            Text("Leaderboard",
                      style: Theme.of(context).textTheme.title,
                      textAlign: TextAlign.center),
          ], mainAxisAlignment: MainAxisAlignment.center),
          actions: <Widget>[IconButton(
            icon: Icon(Icons.menu),
            onPressed: () async {
              await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return dialogWidget();
                  });
            },
            alignment: Alignment.centerRight,
          ),],
          floating: true,
          expandedHeight: dev.screenHeight / 6,
          flexibleSpace: FlexibleSpaceBar(title: Text('Leaderboard'))),
      scoreList()
    ]));
  }

  Widget scoreList() {
    //populate list with data
    if (isLocal) {
      getLocalScores();
    } else {
      getOnlineScores();
      print('test');
    }

    if (displayBoard != null) {
      return SliverFixedExtentList(
          itemExtent: 50,
          delegate: SliverChildBuilderDelegate((context, index) {
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
      return noData();
    }
  }

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
                          setState(() {});
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)))
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
            childCount: 1));
  }

  Widget dialogWidget() {
    if (isLocal) {
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      );
    } else {
      return SimpleDialog(
          children: <Widget>[
            MaterialButton(
                child: Text("Leave Leaderboard",
                    style: Theme.of(context).textTheme.button),
                onPressed: () async {
                  await SharedPreferences.getInstance().then((prefs) {
                    prefs.setString("onlineBoardID", null);
                    Navigator.pushReplacement(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => SelectLeaderboard()));
                  });
                }),
          ],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)));
    }
  }

  getOnlineScores() async {
    final databaseReference = Firestore.instance;
    if (onlineBoardID != null) {
      try {
        await databaseReference
            .collection("Leaderboard")
            .document(onlineBoardID)
            .get()
            .then((documentSnapshot) {
          displayBoard = documentSnapshot["Scores"];
          if (displayBoard.length >= 2) {
            displayBoard.sort((a, b) =>
                jsonDecode(b)["score"].compareTo(jsonDecode(a)["score"]));
          }
        });
      } catch (stacktrace) {
        print(stacktrace.toString());
      }
    }
  }

  getLocalScores() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    displayBoard = prefs.getStringList("localBoard");
  }
}
