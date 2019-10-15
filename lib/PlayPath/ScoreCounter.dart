import 'dart:math';
import 'dart:core';

class ScoreObject{
	int _score;
	Stopwatch _time=Stopwatch();
	timerBegin(){
		_time.start();
	}
	timerEnd(){
		_time.stop();
	}
	calculate(int mazeSize){
		int timeTaken= _time.elapsedMilliseconds;
		double curve = 10*mazeSize*exp((1/10*mazeSize)*timeTaken);
		_score = curve.round();
	}

	int get score => _score;

}
