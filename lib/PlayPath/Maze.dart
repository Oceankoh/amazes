import 'package:flutter/material.dart';
import 'package:a_maze_ment/PlayPath/MazeGenAlgo.dart';
import 'package:a_maze_ment/Globals/DataTypes.dart';

class GenerateMaze extends StatefulWidget {
  final int side;
  GenerateMaze({Key key, @required this.side}) : super(key: key);
  @override
  State createState() => _MazeState(side);
}

class _MazeState extends State<GenerateMaze> {
  int side;
  List<List<Block>> maze;
  MazeGen generator = MazeGen();
  _MazeState(int s) {
    side = s;
    maze = generator.generate(side);
  }
  Coords current=Coords(0, 0);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onPanUpdate: move,
        child: Scaffold(
            backgroundColor: Theme.of(context).canvasColor,
            body: Container(
              padding: EdgeInsets.all(5),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: side),
                itemBuilder: drawMaze,
                itemCount: side * side,
              ),
            )));
  }

  move(DragUpdateDetails details) {
    if (details.delta.dx > 0) {//move right(+x)
      if(!maze[current.getX()][current.getY()].getRight()){
        //move
      }
    } else {//move left(-x)
      if(!maze[current.getX()][current.getY()].getLeft()){
        //move
      }
    }
    if (details.delta.dy > 0) {//move up(+y)
      if(!maze[current.getX()][current.getY()].getUp()){
        //move
      }
    } else {//move down(-y)
      if(!maze[current.getX()][current.getY()].getDown()){
        //move
      }
    }
  }

  Widget drawMaze(BuildContext context, int index) {
    int x, y = 0;
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

    return Container(
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(width: 2, color: up),
                right: BorderSide(width: 2, color: right),
                bottom: BorderSide(width: 2, color: down),
                left: BorderSide(width: 2, color: left))));
  }
}
