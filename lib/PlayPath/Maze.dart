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

class _MazeState extends State<GenerateMaze> with WidgetsBindingObserver {
  //length of one side square grid of the maze
  int side;

  //2 dimensional array to represent the maze grid
  List<List<Block>> maze;

  //coordinates of the current location of the player in the maze
  Coordinates current;

  //maze generator object
  MazeGen generator = MazeGen();

  //Color of the player icon
  Color playerColour = GameSettings.playerColour;

  //Object to control the text field receiving input for the player username
  final textController = TextEditingController();

  //initialisation of maze state
  _MazeState(int s) {
    //storing the specified maze size for usage later
    side = s;
    //DFS generation of maze
    maze = generator.generate(side);
    //reset the previous timer instance to ensure it starts from 0
    playerScore.timerReset();
    //start the player at the top left corner
    maze[0][side - 1].icon = true;
    current = Coordinates(0, side - 1);
    //start the timer
    playerScore.timerBegin();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    textController.dispose();
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
    //check if player has reached the bottom right corner
    if (maze[maze.length - 1][0].getIcon()) {
      // player has reached end
      //play congratulatory audio
      GlobalAudioPlayer.playWinAudio();
      //stop the timer and calculate the score using the total time taken
      playerScore.timerEnd();
      playerScore.calculate(side);
      int finalScore = playerScore.score;
      //show win screen instead of maze
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
      //maze completion in progress
      return Scaffold(
          body: Stack(children: [
        Container(
            decoration: BoxDecoration(color: Theme.of(context).canvasColor),
            padding: EdgeInsets.all(5),
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //set length of grid as specified by the user
                    crossAxisCount: side),
                scrollDirection: Axis.vertical,
                //method loops through entire 2D grid linearly to generate maze
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
    ScoreObject newScore = new ScoreObject(username, score);
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
    //play the movement audio
    GlobalAudioPlayer.playMoveAudio();
    /*
    +========================================================================+
    |   To move a player,                                                    |
    |     1. check if move is valid                                          |
    |     2. change the player icon to be generated at next cell             |
    |     3. increment/decrement the coordinate according to the movement    |
    |     4. rebuild the maze GUI                                            |
    +========================================================================+
     */
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
    /*
      convert the linear index into x, y coordinates
    +===============================================+
    |           258  ->  (0,2)(1,2)(2,2)            |
    |           147  ->  (0,1)(1,1)(2,1)            |
    |           036  ->  (0,0)(1,0)(2,0)            |
    +===============================================+
    */
    x = (index / side).floor();
    y = (index % side);
    //return a GridTile Widget base on 2D maze grid
    return GridTile(
      child: drawGridCell(y, side - 1 - x),
    );
  }

  //generate grid cell base on maze specs
  Widget drawGridCell(int x, y) {
    //set all 4 walls of the cell to be transparent
    Color up = Colors.transparent,
        down = Colors.transparent,
        left = Colors.transparent,
        right = Colors.transparent;

    //set all wall thickness to be size 1
    double T = 1, R = 1, B = 1, L = 1;

    //ensure 2 adjacent cells do not construct
    if (x == 0) L = 2;
    if (x == maze.length - 1) R = 2;
    if (y == 0) B = 2;
    if (y == maze.length - 1) T = 2;
    //blank container to be returned
    Container ret;

    //set color of the walls to be "drawn" to white
    if (maze[x][y].getUp()) up = Colors.white;
    if (maze[x][y].getRight()) right = Colors.white;
    if (maze[x][y].getDown()) down = Colors.white;
    if (maze[x][y].getLeft()) left = Colors.white;

    //check if player is at the node to be generated
    if (maze[x][y].getIcon()) {
      //current node contains the player, hence return a coloured node
      ret = Container(
          decoration: BoxDecoration(
              color: playerColour,
              border: Border(
                  top: BorderSide(width: T, color: up),
                  right: BorderSide(width: R, color: right),
                  bottom: BorderSide(width: B, color: down),
                  left: BorderSide(width: L, color: left))));
    } else if (x == 0 && y == maze.length - 1) {
      //current node is the top left corner, return icon to indicate start of the maze
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
      //current node the bottom right corner, return icon to indicate the end
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
      //current node does not fulfill any of the conditions above, return normal node according to cell specifications
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
}
