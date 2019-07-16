import 'package:flutter/material.dart';
import 'package:a_maze_ment/PlayPath/MazeGenAlgo.dart';
import 'package:a_maze_ment/Globals/DataTypes.dart';
import 'package:a_maze_ment/Globals/device.dart' as dev;
import 'dart:math';
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
  MazeGen generator = MazeGen();
  _MazeState(int s) {
    side = s;
    maze = generator.generate(side);
    maze[0][0].icon = true;
  }

  Coords current = Coords(0, 0);

  @override
  Widget build(BuildContext context) {
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
                height: (dev.screenHeight - dev.screenWidth * 1.2) / 3, width: dev.screenWidth / 3),
            Container(
                key: Key("upButton"),
                child: MaterialButton(
                    height: (dev.screenHeight - dev.screenWidth * 1.2) / 3,
                    minWidth: dev.screenWidth / 3,
                    onPressed: () {},
                    color: Colors.white),
                alignment: Alignment.topCenter)
          ]),
          Row(children: [
            Container(
                key: Key("leftButton"),
                child: MaterialButton(
                    height: (dev.screenHeight - dev.screenWidth * 1.2) / 3,
                    minWidth: dev.screenWidth / 3,
                    onPressed: () {},
                    color: Colors.black),
                alignment: Alignment.centerLeft),
            Container(
                height: (dev.screenHeight - dev.screenWidth * 1.2) / 3, width: dev.screenWidth / 3),
            Container(
                key: Key("rightButton"),
                child: MaterialButton(
                    height: (dev.screenHeight - dev.screenWidth * 1.2) / 3,
                    minWidth: dev.screenWidth / 3,
                    onPressed: () {},
                    color: Colors.brown),
                alignment: Alignment.centerRight)
          ]),
          Row(children: [
            Container(
                height: (dev.screenHeight - dev.screenWidth * 1.2) / 3, width: dev.screenWidth / 3),
            Container(
                key: Key("downButton"),
                child: MaterialButton(
                    height: (dev.screenHeight - dev.screenWidth * 1.2) / 3,
                    minWidth: dev.screenWidth / 3,
                    onPressed: () {},
                    color: Colors.amber),
                alignment: Alignment.bottomCenter)
          ]),
          Row(children: [Container(width: dev.screenWidth * 0.1, height: dev.screenWidth * 0.1)])
        ],
        mainAxisAlignment: MainAxisAlignment.end,
      )
    ]));
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

    if (maze[x][y].getUp()) up = Colors.white;
    if (maze[x][y].getRight()) right = Colors.white;
    if (maze[x][y].getDown()) down = Colors.white;
    if (maze[x][y].getLeft()) left = Colors.white;

    if (maze[x][y].getIcon()) {
      return Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  top: BorderSide(width: 2, color: up),
                  right: BorderSide(width: 2, color: right),
                  bottom: BorderSide(width: 2, color: down),
                  left: BorderSide(width: 2, color: left))));
    } else {
      return Container(
          decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(width: 2, color: up),
                  right: BorderSide(width: 2, color: right),
                  bottom: BorderSide(width: 2, color: down),
                  left: BorderSide(width: 2, color: left))));
    }
  }
}
