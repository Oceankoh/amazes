import 'package:flutter/material.dart';

class GenerateMaze extends StatefulWidget {
  final int side;
  GenerateMaze({Key key, @required this.side}) : super(key: key);
  @override
  State createState() => _MazeState(side);
}

class _MazeState extends State<GenerateMaze> {
  int side;
  List<List<int>> maze;
  _MazeState(int s) {
    side = s;
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
    if (maze[x][y] == 0) {
      //wall
      return Container(color: Theme.of(context).accentColor);
    } else {
      //path
      return Container(color: Theme.of(context).primaryColor);
    }
  }
}
