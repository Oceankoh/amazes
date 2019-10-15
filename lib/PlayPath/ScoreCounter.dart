import 'dart:math';
import 'dart:core';

class ScoreObject{
	int _score;
	Stopwatch _time=Stopwatch();
	timerBegin(){
		_time.start();
		print(_time);
	}
	timerEnd(){
		_time.stop();
		print(_time);
	}
	calculate(int mazeSize){
		double timeTaken= _time.elapsedMilliseconds.toDouble()/1000;
		double curve = 10*mazeSize*mazeSize*exp(-(timeTaken).toDouble()/(mazeSize*mazeSize));
		_score = curve.round();
		_time.reset();
		print(timeTaken);
		print(curve.round());
		print(mazeSize);
	}

	int get score => _score;

}
