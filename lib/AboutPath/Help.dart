import 'package:flutter/material.dart';
import 'package:aMazes/PreApp/Home.dart';
import 'package:aMazes/Globals/device.dart' as dev;
import 'package:aMazes/Globals/DataTypes.dart';

class About extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AboutState();
}

//TODO update help page
class AboutState extends State<About> with WidgetsBindingObserver {
  final String helpGame = """Click on the play button. Select your maze size using either the slider or the manual increments beside it. Once selected press confirm. A random square maze of your specified size will be generated. You will start at the top left and your goal is to navigate your way down to the bottom right corner marked with the star icon. Use the arrow buttons below the maze to move. Be quick on your fingers as there is a timer running immediately after the maze is generated. Your score will be calculated according to your specified size and time taken to complete the maze. After reaching the end, you will be greeted with a winning screen to save your score. Enter your name into the textfield to save your score on the leaderboards.""";
  final String helpLeaderboard = """You can check the leaderboard by pressing the leaderboards button. You can then choose to view either the local leaderboard or an online leaderboard. Your score is automatically saved to the local leaderboard. You may clear the scores at any time by simply clicking on the clear leaderboard button. If you have previously connected to an online leaderboard, your score will also be saved there. Should you be unable to save your score, please ensure you have a stable internet connection. To connect to a new leaderboard, you may either enter the leaderboard ID of an existing board or opt to create a new board. Once your board has been created you may share the boardID with your friends and compete for the top position. Should you choose to join another online leaderboard, you may select the leave leaderboard option.""";
  final String helpSettings = """Clicking on the settings button brings allows you to configure the game settings. You may increase or decrease the Game music or background music by using the sliders. """;
  final String about = """Sorry for the ugly UI.""";
  final String devDetails = """You can find my github and website here"""; //TODO: add link

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      GlobalAudioPlayer.backgroundAudio.then((controller) {
        controller.pause();
      });
      GlobalAudioPlayer.winAudio.then((controller) {
        controller.release();
      });
    }
    if (state == AppLifecycleState.resumed) {
      GlobalAudioPlayer.backgroundAudio.then((controller) {
        controller.resume();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(
                  left: dev.screenWidth * 0.1, top: dev.screenHeight * 0.15),
              child: Text('About', style: Theme.of(context).textTheme.headline)),
          Padding(
              padding: EdgeInsets.all(dev.screenWidth * 0.1),
              child: Text(
                'Notes from the Developer',
                style: Theme.of(context).textTheme.subhead,
              )),
          Padding(
              padding: EdgeInsets.fromLTRB(
                  dev.screenWidth * 0.1, 0, dev.screenWidth * 0.1, dev.screenWidth * 0.2),
              child: Text(
                about,
                style: Theme.of(context).textTheme.body1,
                textAlign: TextAlign.justify,
              )),
          /*Padding(
              padding: EdgeInsets.all(dev.screenWidth * 0.1),
              child: Text(
                'Playing the Game',
                style: Theme.of(context).textTheme.subhead,
              )),
          Padding(
              padding: EdgeInsets.fromLTRB(
                  dev.screenWidth * 0.1, 0, dev.screenWidth * 0.1, 0),
              child: Text(
                helpGame,
                style: Theme.of(context).textTheme.body1,
                textAlign: TextAlign.justify,
              )),
          Padding(
              padding: EdgeInsets.all(dev.screenWidth * 0.1),
              child: Text(
                'Leaderboards',
                style: Theme.of(context).textTheme.subhead,
              )),
          Padding(
              padding: EdgeInsets.fromLTRB(
                  dev.screenWidth * 0.1, 0, dev.screenWidth * 0.1, 0),
              child: Text(helpLeaderboard,
                  style: Theme.of(context).textTheme.body1,
                  textAlign: TextAlign.justify)),
          Padding(
              padding: EdgeInsets.all(dev.screenWidth * 0.1),
              child: Text(
                'Settings',
                style: Theme.of(context).textTheme.subhead,
              )),
          Padding(
              padding: EdgeInsets.fromLTRB(
                  dev.screenWidth * 0.1, 0, dev.screenWidth * 0.1, 0),
              child: Text(helpSettings,
                  style: Theme.of(context).textTheme.body1,
                  textAlign: TextAlign.justify)),*/
          Center(
              child: MaterialButton(
                  height: 50,
                  minWidth: 200,
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => HomePage()));
                  },
                  padding: EdgeInsets.all(dev.screenWidth * 0.01),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  child: Text('Return To Home',
                      style: Theme.of(context).textTheme.button)))
        ],
      ),
    ));
  }
}
