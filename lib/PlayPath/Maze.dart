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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).canvasColor,
        body: Container(
          padding: EdgeInsets.all(5),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: side),
            itemBuilder: drawMaze,
            itemCount: side * side,
          ),
        ));
  }

  Widget drawMaze(BuildContext context, int index) {
    int x, y = 0;
    x = (index / side).floor();
    y = (index % side);
    return GridTile(
      child: drawGridCell(x, y),
    );
  }

  Widget drawGridCell(int x, y) {
    Color up = Colors.transparent,
        down = Colors.transparent,
        left = Colors.transparent,
        right = Colors.transparent;

    if (maze[x][y].up) up = Colors.white;
    if (maze[x][y].right) right = Colors.white;
    if (maze[x][y].down) down = Colors.white;
    if (maze[x][y].left) left = Colors.white;

    return Container(
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(width: 2, color: up),
                right: BorderSide(width: 2, color: right),
                bottom: BorderSide(width: 2, color: down),
                left: BorderSide(width: 2, color: left))));
  }
}
