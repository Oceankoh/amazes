import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                "Background Audio",
              ),
              Slider(value: null, onChanged: null)
            ],
          ),
          Row(
            children: <Widget>[
              Text(
                "Game Audio",
              ),
              Slider(value: null, onChanged: null)
            ],
          ),
          Row(
            children: <Widget>[
              Text("Button Controls"),
              Switch(value: null, onChanged: null)
            ],
          ),
          Row(
            children: <Widget>[
              Text("Swipe Controls"),
              Switch(value: null, onChanged: null)
            ],
          )
        ],
      ),
    );
  }
}
