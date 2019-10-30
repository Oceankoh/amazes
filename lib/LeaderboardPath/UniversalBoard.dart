import 'dart:convert';
import 'package:a_maze_ment/PreApp/Home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:a_maze_ment/Globals/DataTypes.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:a_maze_ment/Globals/device.dart' as dev;

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
  List<String> localBoard;

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
    if (isLocal) {
      getLocalScores();
      if (localBoard != null) {
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
                        child: Text(jsonDecode(localBoard[index])["username"],
                            style: Theme.of(context).textTheme.body1),
                        width: dev.screenWidth / 2),
                    padding: EdgeInsets.all(10),
                  ),
                  Padding(
                      child: Container(
                          child: Text(
                              jsonDecode(localBoard[index])["score"].toString(),
                              style: Theme.of(context).textTheme.body1),
                          width: dev.screenWidth / 5),
                      padding: EdgeInsets.all(10))
                ],
              );
            }, childCount: localBoard.length));
      } else {
        return SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => Column(
                      children: [
                        Text("Unable to get data. Click refresh to try again.",
                            style: Theme.of(context).textTheme.body1),
                        MaterialButton(
                            child: Text("Refresh",
                                style: Theme.of(context).textTheme.button),
                            onPressed: () {
                              setState(() {});
                            })
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                childCount: 1));
      }
    } else {
      return FutureBuilder(
          builder: (BuildContext context, AsyncSnapshot asyncSnap) {
            if (asyncSnap.connectionState == ConnectionState.none &&
                asyncSnap.hasData == null) {
              return Container();
            }
            return ListView.builder(
                itemCount: asyncSnap.data.length,
                itemBuilder: (context, index) {
                  ScoreObject scores = asyncSnap.data[index];
                  return Row();
                });
          },
          future: getOnlineScores());
    }
  }

  Future getOnlineScores() async {
    var scores;
    DatabaseReference database = FirebaseDatabase.instance.reference();
    await database.once().then((DataSnapshot snapshot) {
      scores = snapshot.value;
    });
    return scores;
  }

  getLocalScores() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    localBoard = prefs.getStringList("localBoard");
    return true;
  }
}
