import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:a_maze_ment/Globals/DataTypes.dart';
import 'package:a_maze_ment/Globals/device.dart' as dev;
import 'package:firebase_database/firebase_database.dart';

class UniversalBoard extends StatefulWidget {
  String boardId;
  bool isLocal;

  UniversalBoard({Key key, @required this.boardId, this.isLocal})
      : super(key: key);

  @override
  State createState() => UniversalLeaderboard(boardId, isLocal);
}

class UniversalLeaderboard extends State<UniversalBoard> {
  String privateBoardID;
  bool isLocal;

  UniversalLeaderboard(this.privateBoardID, this.isLocal);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Container(child: Text('Leaderboard')),
      CustomScrollView(slivers: [
        const SliverAppBar(
            pinned: true,
            expandedHeight: 150,
            flexibleSpace: FlexibleSpaceBar(title: Text('Leaderboard'))),
        scoreList()
      ])
    ]));
  }

  Widget scoreList() {
    return FutureBuilder(
        builder: (context, asyncSnap) {
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
        future: getScores());
  }

  Future getScores() async {
    List<ScoreObject> scores;
    if (isLocal) {
      scores = null; //TODO get data from local
      return scores;
    } else {
      DatabaseReference database = FirebaseDatabase.instance.reference();
      await database.once().then((DataSnapshot snapshot) {
        scores = snapshot.value;
      });
      return scores;
    }
  }
}
