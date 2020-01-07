import 'dart:math';
import 'dart:core';
import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'DataTypes.g.dart';

//Represents each square/block in the grid maze
class Block {
  //private booleans up/down/left/right to represent whether the wall exists
  bool _up = true;
  bool _right = true;
  bool _down = true;
  bool _left = true;

  //true if player is at the current block
  bool _icon = false;

  //Represent visited status during maze generation
  bool _visited = false;

  //getter and setter methods for the private variables above
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

//Pair object used to store x,y coordinates in the grid maze
class Coordinates {
  int _x;
  int _y;

  //constructor to initialise every instance of this object
  Coordinates(int x, int y) {
    _x = x;
    _y = y;
  }

  //getter and setter methods for the private variables
  int getX() => _x;

  int getY() => _y;

  set x(int value) {
    _x = value;
  }

  set y(int value) {
    _y = value;
  }
}

//ScoreCounter Object used to calculate the score of a game
class ScoreCounter {
  //variables to store the final score of the game
  int _score;

  //instance of stopwatch object to keep time
  Stopwatch _time = Stopwatch();

  //methods to control the private stopwatch object
  //starts counting
  timerBegin() {
    _time.start();
  }

  //stops counting
  timerEnd() {
    _time.stop();
  }

  //resets the counter
  timerReset() {
    _time.reset();
  }

  //mathematical scoring function
  calculate(int mazeSize) {
    double timeTaken = _time.elapsedMilliseconds.toDouble();
    double curve =
        pow(mazeSize, e) * exp(-(timeTaken/500).toDouble() / pow(mazeSize, e));
    _score = curve.truncate();
  }

  //returns the private score variable
  int get score => _score;
}

//Object to store an instance of a leaderboard entry
//Object is marked as json serializable for database storage purposes
@JsonSerializable()
class ScoreObject {
  //username of the player
  final String username;
  //final score attained by the player
  final int score;

  //constructor for each instance of ScoreObject
  ScoreObject({this.username, this.score});

  //decoding json into ScoreObject
  factory ScoreObject.fromJson(Map<String, dynamic> json) =>
      _$ScoreObjectFromJson(json);

  //encoding ScoreObject to Json
  Map<String, dynamic> toJson() => _$ScoreObjectToJson(this);
}

//Object for non-persistent storage of settings properties to enable faster access
class GameSettings {
  static double gameVolume;
  static double bgVolume;
  static Color playerColour;
}

//static Object controlling all audio assets played
class GlobalAudioPlayer {
  //temporary storage of audio assets
  static AudioCache _player = AudioCache();
  //null variables which would eventually be used to control additional audio properties
  static var backgroundAudio;
  static var moveAudio;
  static var winAudio;

  //loads all audio files into the cache for faster access
  static void load() {
    _player.loadAll(['background.mp3', 'move.mp3', 'win.mp3']);
  }

  //plays background audio
  static void playBgAudio() {
    //specify volume of audio and store the AudioPLayer object return for changes to audio properties while audio is playing
    backgroundAudio =
        _player.loop('background.mp3', volume: GameSettings.bgVolume);
  }

  //plays movement audio
  static void playMoveAudio() {
    //specify volume of audio and store the AudioPLayer object return for changes to audio properties while audio is playing
    moveAudio = _player.play('move.mp3', volume: GameSettings.gameVolume);
  }

  //plays winning audio
  static void playWinAudio() {
    //specify volume of audio and store the AudioPLayer object return for changes to audio properties while audio is playing
    winAudio = _player.play('win.mp3', volume: GameSettings.gameVolume);
  }
}
