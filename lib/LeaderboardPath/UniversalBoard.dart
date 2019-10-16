import 'package:flutter/cupertino.dart';

class UniversalBoard extends StatefulWidget{
  String boardId;
  bool isLocal;

  UniversalBoard({Key key, @required this.boardId, this.isLocal}) : super(key: key);

  @override
  State createState() => UniversalLeaderboard(boardId,isLocal);
}

class UniversalLeaderboard extends State<UniversalBoard>{

  UniversalLeaderboard(String boardID, bool local){
    if(local==true){
      //TODO get data from local DB
    }else{
      //TODO get data based on boardID
    }
}
  @override
  Widget build(BuildContext context) {
    return null;
  }
}