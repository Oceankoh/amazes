import 'dart:math';
import 'dart:core';
import 'package:json_annotation/json_annotation.dart';

part 'DataTypes.g.dart';

class Block {
  bool _up = true;
  bool _right = true;
  bool _down = true;
  bool _left = true;
  bool _icon = false;
  bool _visited = false;

  bool getUp() => _up;

  set up(bool value) {
    _up = value;
  }

  bool getRight() => _right;

  set right(bool value) {
    _right = value;
  }

  bool getDown() => _down;

  set down(bool value) {
    _down = value;
  }

  bool getLeft() => _left;

  set left(bool value) {
    _left = value;
  }

  bool getIcon() => _icon;

  set icon(bool value) {
    _icon = value;
  }

  bool getVisited() => _visited;

  set visited(bool value) {
    _visited = value;
  }
}

class Coords {
  int _x;
  int _y;

  Coords(int x, int y) {
    _x = x;
    _y = y;
  }

  int getX() => _x;

  int getY() => _y;

  set x(int value) {
    _x = value;
  }

  set y(int value) {
    _y = value;
  }
}

class ScoreCounter {
  int _score;
  Stopwatch _time = Stopwatch();

  timerBegin() {
    _time.start();
  }

  timerEnd() {
    _time.stop();
  }

  calculate(int mazeSize) {
    double timeTaken = _time.elapsedMilliseconds.toDouble() / 500;
    double curve =
        pow(mazeSize, e) * exp(-(timeTaken).toDouble() / pow(mazeSize, e));
    _score = curve.truncate();
    _time.reset();
  }

  int get score => _score;
}

@JsonSerializable()
class ScoreObject {
  final String username;
  final int score;
  ScoreObject({this.username, this.score});

  factory ScoreObject.fromJson(Map<String, dynamic> json) =>
      _$ScoreObjectFromJson(json);

  Map<String, dynamic> toJson() => _$ScoreObjectToJson(this);
}

//TODO: determine if need to be removed
class ScoreObjectList {
  final List<ScoreObject> scores;
  ScoreObjectList({this.scores});

  factory ScoreObjectList.fromJson(List<dynamic> json) {
    return ScoreObjectList(
        scores: json
            .map((e) => ScoreObject.fromJson(e as Map<String, dynamic>))
            .toList());
  }

}
