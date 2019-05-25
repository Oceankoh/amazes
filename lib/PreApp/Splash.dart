import 'package:flutter/material.dart';
import 'package:a_maze_ment/PreApp/Home.dart';

import 'dart:async';

class Splash extends StatefulWidget {
	@override
	State createState() => new SplashState();
}

class SplashState extends State<Splash> {
	@override
	void initState() {
		super.initState();
		Future.delayed(Duration(seconds: 3), () {
			Navigator.pushReplacement(
				context, new MaterialPageRoute(builder: (context) => HomePage()));
		});
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Theme.of(context).primaryColor,
			body:
		);
	}
}
