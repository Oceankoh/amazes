import 'dart:math';
import 'dart:collection';
import 'package:aMazes/Globals/DataTypes.dart';

class MazeGen {
  //variables
  List<List<Block>> maze = [];
  Queue<Coordinates> visited = new Queue<Coordinates>();
  int size;

  List<List<Block>> generate(int s) {
    this.size = s;
    for (int i = 0; i < size; i++) {
      List<Block> init = [];
      for (int j = 0; j < size; j++) {
        init.add(Block());
      }
      maze.add(init);
    }
    var rnd = Random();
    int xStart = rnd.nextInt(size);
    int yStart = rnd.nextInt(size);
    algo(Coordinates(xStart, yStart));
    return maze;
  }

  void algo(Coordinates coordinates) {
    int x = coordinates.getX();
    int y = coordinates.getY();

    //mark current as visited
    maze[x][y].visited = true;

    bool unvisited = false;
    List<int> randomizer = [];

    //check for adjacent visited nodes
    if (y + 1 < size) {
      if (!(maze[x][y + 1].getVisited())) {
        //up node
        unvisited = true;
        randomizer.add(1);
      }
    }
    if (x + 1 < size) {
      if (!(maze[x + 1][y].getVisited())) {
        //right node
        unvisited = true;
        randomizer.add(2);
      }
    }
    if (y - 1 >= 0) {
      if (!(maze[x][y - 1].getVisited())) {
        //down node
        unvisited = true;
        randomizer.add(3);
      }
    }
    if (x - 1 >= 0) {
      if (!(maze[x - 1][y].getVisited())) {
        //left node
        unvisited = true;
        randomizer.add(4);
      }
    }
    if (unvisited && randomizer.length > 0) {
      randomizer.shuffle(Random());
      switch (randomizer[0]) {
        case 1: //up
          maze[x][y].up = false;
          maze[x][y + 1].down = false;
          visited.add(Coordinates(x, y));
          algo(Coordinates(x, y + 1));
          break;
        case 2: //right
          maze[x][y].right = false;
          maze[x + 1][y].left = false;
          visited.add(Coordinates(x, y));
          algo(Coordinates(x + 1, y));
          break;
        case 3: //down
          maze[x][y].down = false;
          maze[x][y - 1].up = false;
          visited.add(Coordinates(x, y));
          algo(Coordinates(x, y - 1));
          break;
        case 4: //left
          maze[x][y].left = false;
          maze[x - 1][y].right = false;
          visited.add(Coordinates(x, y));
          algo(Coordinates(x - 1, y));
          break;
      }
    } else if (visited.isNotEmpty) {
      Coordinates prev = visited.removeLast();
      algo(prev);
    }
  }
}
