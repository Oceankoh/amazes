import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return null;
  }
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [

        ],
      ),
    );
  }
}

class NewButton extends StatelessWidget{
  String text;
  newButton(String txt){
    text=txt;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Text('Play',style: TextStyle(color: Theme.of(context).primaryColor)),
          
        ],
      ),
    );
  }
}