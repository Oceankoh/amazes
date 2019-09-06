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
		double score = 10*mazeSize*exp((1/10*mazeSize)*timeTaken);
		_score = score.round();
	}
}
