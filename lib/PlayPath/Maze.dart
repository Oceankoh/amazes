import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aMazes/PlayPath/MazeGenAlgo.dart';
import 'package:aMazes/Globals/DataTypes.dart';
import 'package:aMazes/PreApp/Home.dart';
import 'package:aMazes/Globals/device.dart' as dev;
import 'dart:ui';
import 'dart:convert';

class GenerateMaze extends StatefulWidget {
  final int side;

  GenerateMaze({Key key, @required this.side}) : super(key: key);

  @override
  State createState() => _MazeState(side);
}

ScoreCounter playerScore = ScoreCounter();


class _MazeState extends State<GenerateMaze> {
  int side;
  List<List<Block>> maze;
  Coords current;
  MazeGen generator = MazeGen();

  Color playerColour = GameSettings.playerColour;

  final textController = TextEditingController();

  _MazeState(int s) {
    side = s;
    maze = generator.generate(side);
    playerScore.timerReset(); //ensure timer starts from 0 all the time
    playerScore.timerBegin();
    maze[0][side - 1].icon = true;
    current = Coords(0, side - 1);
  }

  @override
  Widget build(BuildContext context) {
    if (maze[maze.length - 1][0].getIcon()) {
      // player has reached end
      GlobalAudioPlayer.playWinAudio();
      playerScore.timerEnd();
      playerScore.calculate(side);
      int finalScore = playerScore.score;
      return Scaffold(
          body: Column(children: [
        Center(
            child: Text("You Win!!!",
                style: Theme.of(context).textTheme.headline,
                textAlign: TextAlign.center)),
        Center(
            child: Text("Score: " + finalScore.toString(),
                style: Theme.of(context).textTheme.caption,
                textAlign: TextAlign.center)),
        Padding(
            child: TextField(
              decoration: InputDecoration(hintText: "Enter Username"),
              controller: textController,
              maxLength: 20,
              minLines: 1,
            ),
            padding: EdgeInsets.all(10)),
        Padding(
            child: MaterialButton(
                height: 50,
                minWidth: 200,
                onPressed: () {
                  saveScore(textController.text, finalScore);
                  Navigator.pushReplacement(context,
                      new MaterialPageRoute(builder: (context) => HomePage()));
                },
                padding: EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                child: Text('Save Score',
                    style: Theme.of(context).textTheme.button)),
            padding: EdgeInsets.all(20)),
        Padding(
            child: MaterialButton(
                height: 50,
                minWidth: 200,
                onPressed: () {
                  Navigator.pushReplacement(context,
                      new MaterialPageRoute(builder: (context) => HomePage()));
                },
                padding: EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                child: Text('Return To Home',
                    style: Theme.of(context).textTheme.button)),
            padding: EdgeInsets.all(20))
      ], mainAxisAlignment: MainAxisAlignment.center));
    } else {
      //player still in the middle of the maze
      return Scaffold(
          body: Stack(children: [
        Container(
            decoration: BoxDecoration(color: Theme.of(context).canvasColor),
            padding: EdgeInsets.all(5),
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: side),
                scrollDirection: Axis.vertical,
                itemBuilder: drawMaze,
                itemCount: side * side)),
        Column(
          children: [
            Row(children: [
              Container(
                  key: Key("leftButton"),
                  child: MaterialButton(
                      height: (dev.screenHeight - dev.screenWidth * 1.2),
                      minWidth: dev.screenWidth * 0.3,
                      onPressed: () {
                        move(4);
                      },
                      child: Icon(Icons.keyboard_arrow_left,
                          size: dev.screenHeight * 0.1, color: Colors.white)),
                  alignment: Alignment.centerLeft),
              Column(
                children: [
                  Container(
                      key: Key("upButton"),
                      child: MaterialButton(
                          height:
                              (dev.screenHeight - dev.screenWidth * 1.2) / 2,
                          minWidth: dev.screenWidth * 0.4,
                          onPressed: () {
                            move(1);
                          },
                          child: Icon(Icons.keyboard_arrow_up,
                              size: dev.screenHeight * 0.1,
                              color: Colors.white)),
                      alignment: Alignment.topCenter),
                  Container(
                      key: Key("downButton"),
                      child: MaterialButton(
                          height:
                              (dev.screenHeight - dev.screenWidth * 1.2) / 2,
                          minWidth: dev.screenWidth * 0.4,
                          onPressed: () {
                            move(3);
                          },
                          child: Icon(Icons.keyboard_arrow_down,
                              size: dev.screenHeight * 0.1,
                              color: Colors.white)),
                      alignment: Alignment.bottomCenter)
                ],
              ),
              Container(
                  key: Key("rightButton"),
                  child: MaterialButton(
                      height: (dev.screenHeight - dev.screenWidth * 1.2),
                      minWidth: dev.screenWidth * 0.3,
                      onPressed: () {
                        move(2);
                      },
                      child: Icon(Icons.keyboard_arrow_right,
                          size: dev.screenHeight * 0.1, color: Colors.white)),
                  alignment: Alignment.centerRight)
            ]),
            Row(children: [
              Container(
                  width: dev.screenWidth * 0.1, height: dev.screenWidth * 0.1)
            ])
          ],
          mainAxisAlignment: MainAxisAlignment.end,
        )
      ]));
    }
  }

  saveScore(String username, int score) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> leaderBoard = prefs.getStringList("localBoard");
    ScoreObject newScore = new ScoreObject(username: username, score: score);
    leaderBoard.add(jsonEncode(newScore));
    if (leaderBoard.length >= 2)
      leaderBoard.sort((a, b) => jsonDecode(b)["score"]
          .compareTo(jsonDecode(a)["score"])); //sort descending order
    await prefs.setStringList("localBoard", leaderBoard);
    print(leaderBoard);

    if (prefs.getString("onlineBoardID") != null) {
      List<String> scoreAdd = [jsonEncode(newScore)];
      await Firestore.instance
          .collection("Leaderboard")
          .document(prefs.getString("onlineBoardID"))
          .updateData({"Scores": FieldValue.arrayUnion(scoreAdd)});
    }
  }

  move(int direction) async {
    GlobalAudioPlayer.playMoveAudio();
    switch (direction) {
      case 1:
        //move up(+y)
        if (!maze[current.getX()][current.getY()].getUp()) {
          maze[current.getX()][current.getY()].icon = false;
          maze[current.getX()][current.getY() + 1].icon = true;
          current.y = current.getY() + 1;
          setState(() {});
        }
        break;
      case 2:
        //move right(+x)
        if (!maze[current.getX()][current.getY()].getRight()) {
          maze[current.getX()][current.getY()].icon = false;
          maze[current.getX() + 1][current.getY()].icon = true;
          current.x = current.getX() + 1;
          setState(() {});
        }
        break;
      case 3:
        //move down(-y)
        if (!maze[current.getX()][current.getY()].getDown()) {
          maze[current.getX()][current.getY()].icon = false;
          maze[current.getX()][current.getY() - 1].icon = true;
          current.y = current.getY() - 1;
          setState(() {});
        }
        break;
      case 4:
        //move left(-x)
        if (!maze[current.getX()][current.getY()].getLeft()) {
          maze[current.getX()][current.getY()].icon = false;
          maze[current.getX() - 1][current.getY()].icon = true;
          current.x = current.getX() - 1;
          setState(() {});
        }
    }
  }

  Widget drawMaze(BuildContext context, int index) {
    int x = 0, y = 0;
    x = (index / side).floor();
    y = (index % side);
    return GridTile(
      child: drawGridCell(y, side - 1 - x),
    );
  }

  Widget drawGridCell(int x, y) {
    Color up = Colors.transparent,
        down = Colors.transparent,
        left = Colors.transparent,
        right = Colors.transparent;

    double T = 1, R = 1, B = 1, L = 1;

    if (x == 0) L = 2;
    if (x == maze.length - 1) R = 2;
    if (y == 0) B = 2;
    if (y == maze.length - 1) T = 2;

    Container ret;
    if (maze[x][y].getUp()) up = Colors.white;
    if (maze[x][y].getRight()) right = Colors.white;
    if (maze[x][y].getDown()) down = Colors.white;
    if (maze[x][y].getLeft()) left = Colors.white;

    if (maze[x][y].getIcon()) {
      ret = Container(
          decoration: BoxDecoration(
              color: playerColour,
              border: Border(
                  top: BorderSide(width: T, color: up),
                  right: BorderSide(width: R, color: right),
                  bottom: BorderSide(width: B, color: down),
                  left: BorderSide(width: L, color: left))));
    } else if (x == 0 && y == maze.length - 1) {
      ret = Container(
          child: Icon(MdiIcons.arrowBottomRightBoldOutline,
              color: Colors.white, size: dev.screenWidth / (2 * side)),
          decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(width: T, color: up),
                  right: BorderSide(width: R, color: right),
                  bottom: BorderSide(width: B, color: down),
                  left: BorderSide(width: L, color: left))));
    } else if (x == maze.length - 1 && y == 0) {
      ret = Container(
          child: Icon(MdiIcons.starCircleOutline,
              color: Colors.white, size: dev.screenWidth / (2 * side)),
          decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(width: T, color: up),
                  right: BorderSide(width: R, color: right),
                  bottom: BorderSide(width: B, color: down),
                  left: BorderSide(width: L, color: left))));
    } else {
      ret = Container(
          decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(width: T, color: up),
                  right: BorderSide(width: R, color: right),
                  bottom: BorderSide(width: B, color: down),
                  left: BorderSide(width: L, color: left))));
    }

    return ret;
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}
