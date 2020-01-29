import 'dart:math';
import 'dart:collection';
import 'package:aMazes/Globals/DataTypes.dart';

class MazeGen {
  //2-dimensional grid of Block object
  List<List<Block>> maze = [];
  //queue to store previously visited since stack are unavailable in dart
  Queue<Coordinates> visited = Queue<Coordinates>();
  //size of maze to be generated
  int size;

  //maze generation method
  List<List<Block>> generate(int s) {
    //save maze size for usage outside the method
    this.size = s;
    //nested loops to initialise entire grid with a new instance of Block
    for (int i = 0; i < size; i++) {
      List<Block> init = [];
      for (int j = 0; j < size; j++) {
        init.add(Block());
      }
      maze.add(init);
    }
    //random object used to generate random numbers
    var rnd = Random();
    //randomise the starting position of the DFS algorithm
    int xStart = rnd.nextInt(size);
    int yStart = rnd.nextInt(size);
    //recursive DFS starting at the randomised coordinates
    algo(Coordinates(xStart, yStart));
    //return the generated maze
    return maze;
  }

  //DFS algorithm to generate maze
  void algo(Coordinates coordinates) {
    //current coordinates of the algorithm
    int x = coordinates.getX();
    int y = coordinates.getY();

    //mark current node as visited
    maze[x][y].visited = true;

    //marked true if there is unvisited node
    bool unvisited = false;
    //list used to randomize which node to pick by shuffling
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

    //check if there are unvisited nodes
    if (unvisited && randomizer.length > 0) {
      /*
      unvisited nodes exists
      +======================================================================+
      |   1. shuffle the list of unvisited nodes and pick the top element    |
      |   2. increment/decrement the coordinates accordingly                 |
      |   3. push the node to the "stack"                                    |
      |   4. run algo with the new coordinates                               |
      +======================================================================+
       */
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
      /*
      all adjacent nodes are visited already
      +=====================================================================+
      |   1. pop the previous node off the stack                            |
      |   2. run algo at the previous node                                  |
      +=====================================================================+
       */
      Coordinates prev = visited.removeLast();
      algo(prev);
    }
  }
}
