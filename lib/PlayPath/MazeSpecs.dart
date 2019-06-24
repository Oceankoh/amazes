import 'package:flutter/material.dart';
import 'package:a_maze_ment/PlayPath/Maze.dart';

class Sizing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).canvasColor,
        body: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => GenerateMaze(side: 5)));
                },
                color: Theme.of(context).primaryColor,
                height: 50,
                minWidth: 300,
                padding: EdgeInsets.all(10),
                child: Text(
                  "5 X 5",
                  style: Theme.of(context).textTheme.button,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => GenerateMaze(side: 6)));
                },
                color: Theme.of(context).primaryColor,
                height: 50,
                minWidth: 300,
                padding: EdgeInsets.all(10),
                child: Text(
                  "6 X 6",
                  style: Theme.of(context).textTheme.button,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => GenerateMaze(side: 7)));
                },
                color: Theme.of(context).primaryColor,
                height: 50,
                minWidth: 300,
                padding: EdgeInsets.all(10),
                child: Text(
                  "7 X 7",
                  style: Theme.of(context).textTheme.button,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => GenerateMaze(side: 8)));
                },
                color: Theme.of(context).primaryColor,
                height: 50,
                minWidth: 300,
                padding: EdgeInsets.all(10),
                child: Text(
                  "8 X 8",
                  style: Theme.of(context).textTheme.button,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => GenerateMaze(side: 9)));
                },
                color: Theme.of(context).primaryColor,
                height: 50,
                minWidth: 300,
                padding: EdgeInsets.all(10),
                child: Text(
                  "9 X 9",
                  style: Theme.of(context).textTheme.button,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => GenerateMaze(side: 10)));
                },
                color: Theme.of(context).primaryColor,
                height: 50,
                minWidth: 300,
                padding: EdgeInsets.all(10),
                child: Text(
                  "10 X 10",
                  style: Theme.of(context).textTheme.button,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => GenerateMaze(side: 11)));
                },
                color: Theme.of(context).primaryColor,
                height: 50,
                minWidth: 300,
                padding: EdgeInsets.all(10),
                child: Text(
                  "11 X 11",
                  style: Theme.of(context).textTheme.button,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => GenerateMaze(side: 12)));
                },
                color: Theme.of(context).primaryColor,
                height: 50,
                minWidth: 300,
                padding: EdgeInsets.all(10),
                child: Text(
                  "12 X 12",
                  style: Theme.of(context).textTheme.button,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => GenerateMaze(side: 13)));
                },
                color: Theme.of(context).primaryColor,
                height: 50,
                minWidth: 300,
                padding: EdgeInsets.all(10),
                child: Text(
                  "13 X 13",
                  style: Theme.of(context).textTheme.button,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => GenerateMaze(side: 14)));
                },
                color: Theme.of(context).primaryColor,
                height: 50,
                minWidth: 300,
                padding: EdgeInsets.all(10),
                child: Text(
                  "14 X 14",
                  style: Theme.of(context).textTheme.button,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => GenerateMaze(side: 15)));
                },
                color: Theme.of(context).primaryColor,
                height: 50,
                minWidth: 300,
                padding: EdgeInsets.all(10),
                child: Text(
                  "15 X 15",
                  style: Theme.of(context).textTheme.button,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => GenerateMaze(side: 16)));
                },
                color: Theme.of(context).primaryColor,
                height: 50,
                minWidth: 300,
                padding: EdgeInsets.all(10),
                child: Text(
                  "16 X 16",
                  style: Theme.of(context).textTheme.button,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => GenerateMaze(side: 17)));
                },
                color: Theme.of(context).primaryColor,
                height: 50,
                minWidth: 300,
                padding: EdgeInsets.all(10),
                child: Text(
                  "17 X 17",
                  style: Theme.of(context).textTheme.button,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => GenerateMaze(side: 18)));
                },
                color: Theme.of(context).primaryColor,
                height: 50,
                minWidth: 300,
                padding: EdgeInsets.all(10),
                child: Text(
                  "18 X 18",
                  style: Theme.of(context).textTheme.button,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => GenerateMaze(side: 19)));
                },
                color: Theme.of(context).primaryColor,
                height: 50,
                minWidth: 300,
                padding: EdgeInsets.all(10),
                child: Text(
                  "19 X 19",
                  style: Theme.of(context).textTheme.button,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => GenerateMaze(side: 20)));
                },
                color: Theme.of(context).primaryColor,
                height: 50,
                minWidth: 300,
                padding: EdgeInsets.all(10),
                child: Text(
                  "20 X 20",
                  style: Theme.of(context).textTheme.button,
                ),
              ),
            ),
          ],
        ));
  }
}
