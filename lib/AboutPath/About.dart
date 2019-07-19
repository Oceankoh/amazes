import 'package:flutter/material.dart';
import 'package:a_maze_ment/PreApp/Home.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Text('Title',style: Theme.of(context).textTheme.title),
          Text('Body',style: Theme.of(context).textTheme.body1,),
          MaterialButton(onPressed: () {
            Navigator.push(context, new MaterialPageRoute(builder: (context) => HomePage()));
          })
        ],
      ),
    );
  }
}
