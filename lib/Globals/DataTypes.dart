import 'dart:math';
import 'dart:core';
import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
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

  timerReset() {
    _time.reset();
  }

  calculate(int mazeSize) {
    double timeTaken = _time.elapsedMilliseconds.toDouble() / 500;
    double curve =
        pow(mazeSize, e) * exp(-(timeTaken).toDouble() / pow(mazeSize, e));
    _score = curve.truncate();
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

class GameSettings {
  static double gameVolume;
  static double bgVolume;
  static Color playerColour;
}

class GlobalAudioPlayer {
  static AudioCache _player = AudioCache();
  static var backgroundAudio;
  static var gameAudio;

  static void load() {
    _player.loadAll(['background.mp3', 'game.mp3']);
  }

  static void playBgAudio() {
    backgroundAudio = _player.loop('background.mp3', volume: GameSettings.bgVolume);
  }

  static void playGameAudio() {
    gameAudio = _player.play('game.mp3', volume: GameSettings.gameVolume);
  }
}
