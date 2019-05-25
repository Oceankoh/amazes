import 'package:flutter/material.dart';
import 'package:a_maze_ment/PreApp/Splash.dart';

void main() => runApp(BaseApp());

class BaseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Splash());
  }
}