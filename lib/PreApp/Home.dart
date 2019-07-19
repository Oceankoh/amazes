import 'package:flutter/material.dart';
import 'package:a_maze_ment/PlayPath/MazeSpecs.dart';
import 'package:a_maze_ment/Globals/device.dart' as dev;
import 'package:animator/animator.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
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
                minWidth: dev.screenWidth * 0.5,
                onPressed: () {
                  Navigator.push(context, new MaterialPageRoute(builder: (context) => Sizing()));
                },
                padding: EdgeInsets.all(10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
                child: Row(children: [
                  Container(width: dev.screenWidth * 0.2),
                  Icon(MdiIcons.gamepad),
                  Container(width: dev.screenWidth * 0.02),
                  Text('PLAY', style: Theme.of(context).textTheme.button)
                ]),
              ),
              padding: EdgeInsets.all(10),
            ),
            Padding(
                child: MaterialButton(
                  minWidth: dev.screenWidth * 0.5,
                  onPressed: () {},
                  padding: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
                  child: Row(children: [
                    Container(width: dev.screenWidth * 0.2),
                    Icon(Icons.settings),
                    Container(width: dev.screenWidth * 0.02),
                    Text('SETTINGS', style: Theme.of(context).textTheme.button)
                  ]),
                ),
                padding: EdgeInsets.all(10)),
            Padding(
                child: MaterialButton(
                  minWidth: dev.screenWidth * 0.5,
                  onPressed: () {},
                  padding: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
                  child: Row(children: [
                    Container(width: dev.screenWidth * 0.2),
                    Icon(MdiIcons.trophy),
                    Container(width: dev.screenWidth * 0.02),
                    Text('LEADERBOARDS', style: Theme.of(context).textTheme.button)
                  ]),
                ),
                padding: EdgeInsets.all(10)),
            Padding(
                child: MaterialButton(
                  minWidth: dev.screenWidth * 0.5,
                  onPressed: () {},
                  padding: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
                  child: Row(children: [
                    Container(width: dev.screenWidth * 0.2),
                    Icon(MdiIcons.information),
                    Container(width: dev.screenWidth * 0.02),
                    Text('ABOUT', style: Theme.of(context).textTheme.button)
                  ]),
                ),
                padding: EdgeInsets.all(10))
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
                transform: Matrix4.translationValues(dev.screenWidth, dev.screenHeight, 0))
          ]))
        ]));
  }
}
