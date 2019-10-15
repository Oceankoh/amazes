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
		double curve = pow(mazeSize,e)*exp(-(timeTaken).toDouble()/pow(mazeSize,e));
		_score = curve.truncate();
		_time.reset();
		print(curve);
	}

	int get score => _score;

}
