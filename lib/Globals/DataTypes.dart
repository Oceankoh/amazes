class Block {
	bool _up = true;
	bool _right = true;
	bool _down = true;
	bool _left = true;
	bool _visited = false;

	// ignore: unnecessary_getters_setters
	bool getup() => _up;
	// ignore: unnecessary_getters_setters
	set up(bool value) {
		_up = value;
	}

	// ignore: unnecessary_getters_setters
	bool getright() => _right;
	// ignore: unnecessary_getters_setters
	set right(bool value) {
		_right = value;
	}

	// ignore: unnecessary_getters_setters
	bool getdown() => _down;
	// ignore: unnecessary_getters_setters
	set down(bool value) {
		_down = value;
	}

	// ignore: unnecessary_getters_setters
	bool getleft() => _left;
	// ignore: unnecessary_getters_setters
	set left(bool value) {
		_left = value;
	}

	// ignore: unnecessary_getters_setters
	bool getvisited() => _visited;
	// ignore: unnecessary_getters_setters
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

	int getX() {
		return _x;
	}
	int getY() {
		return _y;
	}
}