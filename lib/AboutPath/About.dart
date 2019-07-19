import 'package:flutter/material.dart';
import 'package:a_maze_ment/PreApp/Home.dart';
import 'package:a_maze_ment/Globals/device.dart' as dev;

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(left: dev.screenWidth * 0.1, top: dev.screenHeight * 0.15),
              child: Text('About', style: Theme.of(context).textTheme.title)),
          Padding(
              padding: EdgeInsets.all(dev.screenWidth * 0.1),
              child: Text(
                'Body',
                style: Theme.of(context).textTheme.body1,
              )),
          Padding(
              child: MaterialButton(
                  height: 50,
                  minWidth: 200,
                  onPressed: () {
                    Navigator.push(
                        context, new MaterialPageRoute(builder: (context) => HomePage()));
                  },
                  padding: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                  child: Text('Return To Home', style: Theme.of(context).textTheme.button)),
              padding: EdgeInsets.all(20))
        ],
      ),
    );
  }
}
