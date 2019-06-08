import 'package:flutter/material.dart';

class GenerateSwipeMaze extends StatefulWidget{
	final int side;
	GenerateSwipeMaze({Key key, @required this.side}) : super(key: key);
	@override
	State createState() => _MazeState(side);
}

class _MazeState extends State<GenerateSwipeMaze>{
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

