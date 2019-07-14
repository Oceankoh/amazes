class Block {
  bool _up = true;
  bool _right = true;
  bool _down = true;
  bool _left = true;
  bool _icon = false;
  bool _visited = false;

  bool getUp() => _up;

  set up(bool value) {
    _up = value;
  }

  bool getRight() => _right;

  set right(bool value) {
    _right = value;
  }

  bool getDown() => _down;

  set down(bool value) {
    _down = value;
  }

  bool getLeft() => _left;

  set left(bool value) {
    _left = value;
  }

  bool getIcon() => _icon;

  set icon(bool value) {
    _icon = value;
  }

  bool getVisited() => _visited;

  set visited(bool value) {
    _visited = value;
  }
}

class Coords {
  int _x;
  int _y;
  Coords(int x, int y) {
    _x = x;
    _y = y;
  }

  int getX() => _x;

  int getY() => _y;

  set x(int value) {
    _x = value;
  }

  set y(int value) {
    _y = value;
  }
}
