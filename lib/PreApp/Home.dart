import 'package:flutter/material.dart';
import 'package:a_maze_ment/PlayPath/MazeSpecs.dart';
import 'package:animator/animator.dart';
import 'package:a_maze_ment/Globals/device.dart' as dev;
import 'dart:math';

class HomePage extends StatefulWidget {
  @override
  State createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).canvasColor,
        body: Stack(children: [
          Container(
              child: Center(
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
              child: MaterialButton(
                height: 50,
                minWidth: 200,
                onPressed: () {
                  Navigator.push(context, new MaterialPageRoute(builder: (context) => Sizing()));
                },
                //   color: Theme.of(context).buttonColor,
                padding: EdgeInsets.all(10),
                shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(13)),
                child: Text('PLAY', style: Theme.of(context).textTheme.button),
              ),
              padding: EdgeInsets.all(20),
            ),
            Padding(
                child: MaterialButton(
                  height: 50,
                  minWidth: 200,
                  onPressed: () {},
                  //  color: Theme.of(context).buttonColor,
                  padding: EdgeInsets.all(10),
                  shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(13)),
                  child: Text('SETTINGS', style: Theme.of(context).textTheme.button),
                ),
                padding: EdgeInsets.all(20)),
            Padding(
                child: MaterialButton(
                  height: 50,
                  minWidth: 200,
                  onPressed: () {},
                  // color: Theme.of(context).buttonColor,
                  padding: EdgeInsets.all(10),
                  shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(13)),
                  child: Text('LEADERBOARDS', style: Theme.of(context).textTheme.button),
                ),
                padding: EdgeInsets.all(20)),
            Padding(
                child: MaterialButton(
                  height: 50,
                  minWidth: 200,
                  onPressed: () {},
                  //   color: Theme.of(context).buttonColor,
                  padding: EdgeInsets.all(10),
                  shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(13)),
                  child: Text('ABOUT', style: Theme.of(context).textTheme.button),
                ),
                padding: EdgeInsets.all(20))
          ]))),
          Container(
              child: Stack(children: [
            Center(
                child: Animator(
                    tween: Tween<double>(begin: 0, end: 2 * pi),
                    duration: Duration(seconds: 8),
                    repeats: 0,
                    curve: Curves.linear,
                    builder: (anim) => Transform.rotate(
                        angle: anim.value,
                        child: Container(
                            decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage('assets/MazeCircle.png')),
                          shape: BoxShape.circle,
                        )))),
                widthFactor: 0.01,
                heightFactor: 0.01),
            Transform(
              child: Center(
                  child: Animator(
                      tween: Tween<double>(begin: 0, end: 2 * pi),
                      duration: Duration(seconds: 8),
                      repeats: 0,
                      curve: Curves.linear,
                      builder: (anim) => Transform.rotate(
                          angle: anim.value,
                          child: Container(
                              decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage('assets/MazeCircle.png')),
                            shape: BoxShape.circle,
                          )))),
                  widthFactor: 0.01,
                  heightFactor: 0.01),
                transform: Matrix4.translationValues(dev.screenWidth, dev.screenHeight, 0)
            )
          ]))
        ]));
  }
}
