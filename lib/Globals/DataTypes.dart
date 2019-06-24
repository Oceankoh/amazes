class Block {
	bool left = true,
		right = true,
		up = true,
		down = true,
		visited = false;
}

class Coords {
	int x, y;
	Coords(int x, y) {
		this.x = x;
		this.y = y;
	}
	int getX(){
		return this.x;
	}
	int getY(){
		return this.y;
	}
}