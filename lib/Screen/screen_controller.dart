import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tankgame/Screen/home_screen.dart';
import 'package:tankgame/Screen/main_screen.dart';
import 'package:tankgame/Screen/menu_screen.dart';
import 'package:tankgame/Screen/play_screen.dart';
import 'package:tankgame/Screen/player_details.dart';
import 'package:tankgame/components/game_status.dart';

import '../game_controller.dart';
class Controller extends StatefulWidget {
  final GameController gameController;
  Controller({this.gameController});

  @override
  _ControllerState createState() => _ControllerState();
}

class _ControllerState extends State<Controller> {


  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    return Container(
      color: Colors.blue,
      child: getWidget(),
    );

  }

  Widget getWidget() {
    Widget myWidget;
    Status gameStatus = widget.gameController.gameStatus;
//    if(gameStatus == Stat us.menu)
//      myWidget = MenuScreen(gameController: widget.gameController, updateState: updateState);

    if(gameStatus == Status.playing)
      myWidget = PlayScreen(gameController: widget.gameController,);
    else if(gameStatus == Status.homeScreen)
      myWidget = HomeScreen(gameController: widget.gameController,updateState: updateState,);
    else if(gameStatus == Status.playerDetails)
      myWidget = PlayerDetails(gameController: widget.gameController,updateState: updateState,);
    else if(gameStatus == Status.mainScreen)
      myWidget = AnimationCircle(gameController: widget.gameController,updateState: updateState);
    else if(gameStatus == Status.menu)
      myWidget = MenuScreen(gameController: widget.gameController, updateState: updateState,);
//    return myWidget;
    return PlayScreen(gameController: widget.gameController,);
  }

  void updateState() {
    setState(() {});
  }

}
