import 'package:flutter/material.dart';

class GenerateMaze extends StatefulWidget {
	final int side;
	GenerateMaze({Key key, @required this.side}) : super(key: key);
	@override
	State createState() => _MazeState(side);
}

class _MazeState extends State<GenerateMaze> {
	int side;
	_MazeState(int s){
		side=s;
	}

	@override
	Widget build(BuildContext context) {
		// TODO: implement build
		return null;
	}
}
