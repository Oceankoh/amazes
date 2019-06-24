import 'dart:math';
import 'dart:collection';
import 'package:a_maze_ment/Globals/DataTypes.dart';

class MazeGen {
  //variables
  List<List<Block>> maze = [];
  Queue<Coords> visited = new Queue<Coords>();
  int size;
  List<List<Block>> generate(int size) {
    List<Block> init = [];
    Block blk = Block();
    this.size = size;
    for (int i = 0; i < size; i++) init.add(blk);
    for (int i = 0; i < size; i++) maze.add(init);
    var rndx = Random();
    int x = rndx.nextInt(size);
    int y = rndx.nextInt(size);
    maze[x][y].visited = true;
    visited.add(Coords(x, y));
    algo(Coords(x, y));
    return maze;
  }

  void algo(Coords coordinates) {
    int x = coordinates.x;
    int y = coordinates.y;
    bool unvisited = false;
    List<int> randomizer = [];
    if (y + 1 < size) {
      if (!(maze[x][y + 1].visited)) {
        //up node
        unvisited = true;
        randomizer.add(1);
      }
    }
    if (x + 1 < size) {
      if (!(maze[x + 1][y].visited)) {
        //right node
        unvisited = true;
        randomizer.add(2);
      }
    }
    if (y - 1 >= 0) {
      if (!(maze[x][y - 1].visited)) {
        //down node
        unvisited = true;
        randomizer.add(3);
      }
    }
    if (x - 1 >= 0) {
      if (!(maze[x - 1][y].visited)) {
        //left node
        unvisited = true;
        randomizer.add(4);
      }
    }
    if (unvisited) {
      randomizer.shuffle(Random()); //possible error here that doesn't ensure randomness
      switch (randomizer[0]) {
        case 1: //up
          maze[x][y].up = false;
          maze[x][y + 1].down = false;
          maze[x][y].visited = true;
          visited.add(Coords(x, y));
          algo(Coords(x, y + 1));
          break;
        case 2: //right
          maze[x][y].right = false;
          maze[x + 1][y].left = false;
          maze[x][y].visited = true;
          visited.add(Coords(x, y));
          algo(Coords(x + 1, y));
          break;
        case 3: //down
          maze[x][y].down = false;
          maze[x][y - 1].up = false;
          maze[x][y].visited = true;
          visited.add(Coords(x, y));
          algo(Coords(x, y - 1));
          break;
        case 4: //left
          maze[x][y].left = false;
          maze[x - 1][y].right = false;
          maze[x][y].visited = true;
          visited.add(Coords(x, y));
          algo(Coords(x - 1, y));
          break;
      }
    } else if (visited.isNotEmpty) {
      Coords prev = visited.removeLast();
      algo(prev);
    }
  }
}
