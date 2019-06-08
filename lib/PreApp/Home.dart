import 'package:flutter/material.dart';
import 'package:a_maze_ment/PlayPath/MazeSpecs.dart';

class HomePage extends StatefulWidget {
  @override
  State createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).canvasColor,
        body: Container(
            child: Center(
                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            child: MaterialButton(
              height: 50,
              minWidth: 200,
              onPressed: () {
                Navigator.push(context, new MaterialPageRoute(builder: (context) => Sizing()));
              },
              color: Theme.of(context).primaryColor,
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
                color: Theme.of(context).primaryColor,
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
                color: Theme.of(context).primaryColor,
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
                color: Theme.of(context).primaryColor,
                padding: EdgeInsets.all(10),
                shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(13)),
                child: Text('ABOUT', style: Theme.of(context).textTheme.button),
              ),
              padding: EdgeInsets.all(20))
        ]))));
  }
}
