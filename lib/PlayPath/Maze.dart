import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:a_maze_ment/PlayPath/MazeGenAlgo.dart';
import 'package:a_maze_ment/Globals/DataTypes.dart';
import 'package:a_maze_ment/PreApp/Home.dart';
import 'package:a_maze_ment/Globals/device.dart' as dev;
import 'dart:ui';

class GenerateMaze extends StatefulWidget {
  final int side;
  GenerateMaze({Key key, @required this.side}) : super(key: key);
  @override
  State createState() => _MazeState(side);
}

class GamePad extends MultiChildLayoutDelegate {
  @override
  void performLayout(Size size) {
    // TODO: implement performLayout
  }

  @override
  bool shouldRelayout(MultiChildLayoutDelegate oldDelegate) {
    // TODO: implement shouldRelayout
    return null;
  }
}

class _MazeState extends State<GenerateMaze> {
  int side;
  List<List<Block>> maze;
  Coords current;
  MazeGen generator = MazeGen();
  _MazeState(int s) {
    side = s;
    maze = generator.generate(side);
    maze[0][side - 1].icon = true;
    current = Coords(0, side - 1);
  }

  @override
  Widget build(BuildContext context) {
    if (maze[maze.length - 1][0].getIcon()) {
      return Scaffold(
          body: Column(children: [
        Center(
            child: Text("You Win!!!",
                style: Theme.of(context).textTheme.headline, textAlign: TextAlign.center)),
        Padding(
            child: MaterialButton(
                height: 50,
                minWidth: 200,
                onPressed: () {
                  Navigator.push(context, new MaterialPageRoute(builder: (context) => HomePage()));
                },
                padding: EdgeInsets.all(10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                child: Text('Return To Home', style: Theme.of(context).textTheme.button)),
            padding: EdgeInsets.all(20))
      ], mainAxisAlignment: MainAxisAlignment.center));
    } else {
      return Scaffold(
          body: Stack(children: [
        Container(
            decoration: BoxDecoration(color: Theme.of(context).canvasColor),
            padding: EdgeInsets.all(5),
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: side),
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
                          height: (dev.screenHeight - dev.screenWidth * 1.2) / 2,
                          minWidth: dev.screenWidth * 0.4,
                          onPressed: () {
                            move(1);
                          },
                          child: Icon(Icons.keyboard_arrow_up,
                              size: dev.screenHeight * 0.1, color: Colors.white)),
                      alignment: Alignment.topCenter),
                  Container(
                      key: Key("downButton"),
                      child: MaterialButton(
                          height: (dev.screenHeight - dev.screenWidth * 1.2) / 2,
                          minWidth: dev.screenWidth * 0.4,
                          onPressed: () {
                            move(3);
                          },
                          child: Icon(Icons.keyboard_arrow_down,
                              size: dev.screenHeight * 0.1, color: Colors.white)),
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
            Row(children: [Container(width: dev.screenWidth * 0.1, height: dev.screenWidth * 0.1)])
          ],
          mainAxisAlignment: MainAxisAlignment.end,
        )
      ]));
    }
  }

  move(int direction) {
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
    Container ret;
    if (maze[x][y].getUp()) up = Colors.white;
    if (maze[x][y].getRight()) right = Colors.white;
    if (maze[x][y].getDown()) down = Colors.white;
    if (maze[x][y].getLeft()) left = Colors.white;

    if (maze[x][y].getIcon()) {
      ret = Container(
          decoration: BoxDecoration(
              color: Colors.red,
              border: Border(
                  top: BorderSide(width: 2, color: up),
                  right: BorderSide(width: 2, color: right),
                  bottom: BorderSide(width: 2, color: down),
                  left: BorderSide(width: 2, color: left))));
    } else if (x == 0 && y == maze.length - 1) {
      ret = Container(
          child: Icon(MdiIcons.arrowBottomRightBoldOutline,
              color: Colors.white, size: dev.screenWidth / (2 * side)),
          decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(width: 2, color: up),
                  right: BorderSide(width: 2, color: right),
                  bottom: BorderSide(width: 2, color: down),
                  left: BorderSide(width: 2, color: left))));
    } else if (x == maze.length - 1 && y == 0) {
      ret = Container(
          child: Icon(MdiIcons.starCircleOutline, color: Colors.white, size: dev.screenWidth / (2 * side)),
          decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(width: 2, color: up),
                  right: BorderSide(width: 2, color: right),
                  bottom: BorderSide(width: 2, color: down),
                  left: BorderSide(width: 2, color: left))));
    } else {
      ret = Container(
          decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(width: 2, color: up),
                  right: BorderSide(width: 2, color: right),
                  bottom: BorderSide(width: 2, color: down),
                  left: BorderSide(width: 2, color: left))));
    }

    return ret;
  }
}
