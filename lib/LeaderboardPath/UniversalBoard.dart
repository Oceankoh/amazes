import 'dart:convert';
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
  String privateBoardID;
  bool isLocal;
  List<dynamic> displayBoard;

  UniversalLeaderboard(this.privateBoardID, this.isLocal);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(shrinkWrap: true, slivers: <Widget>[
          SliverAppBar(
              pinned: true,
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
                            style: Theme
                                .of(context)
                                .textTheme
                                .body1),
                        width: dev.screenWidth / 10),
                    padding: EdgeInsets.all(10)),
                Padding(
                  child: Container(
                      child: Text(jsonDecode(displayBoard[index])["username"],
                          style: Theme
                              .of(context)
                              .textTheme
                              .body1),
                      width: dev.screenWidth / 2),
                  padding: EdgeInsets.all(10),
                ),
                Padding(
                    child: Container(
                        child: Text(
                            jsonDecode(displayBoard[index])["score"].toString(),
                            style: Theme
                                .of(context)
                                .textTheme
                                .body1),
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
        itemExtent: 100,
        delegate: SliverChildBuilderDelegate(
                (context, index) =>
                Column(
                  children: [
                    Text("Unable to get data. Click refresh to try again.",
                        style: Theme
                            .of(context)
                            .textTheme
                            .body1),
                    MaterialButton(
                        child: Text("Refresh",
                            style: Theme
                                .of(context)
                                .textTheme
                                .button),
                        onPressed: () {
                          setState(() {});
                        })
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
            childCount: 1));
  }

  getOnlineScores() async {
    final databaseReference = Firestore.instance;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String prevBoard = "dgJDdOIsc70Vu2EHoDXB";//prefs.getString("onlineBoard");
    if (prevBoard != null) {
      try {
        await databaseReference
            .collection("Leaderboard")
            .document(prevBoard)
            .get().then((documentSnapshot) {
           var test = documentSnapshot["Scores"];
           displayBoard = test;
           print(test.length);
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
