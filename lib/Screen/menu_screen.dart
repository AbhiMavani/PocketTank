import 'package:flutter/material.dart';
import 'package:tankgame/components/game_status.dart';
import 'package:tankgame/game_controller.dart';

class MenuScreen extends StatelessWidget {
  final GameController gameController;
  final Function updateState;
  const MenuScreen({Key key, this.gameController, this.updateState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: RaisedButton(
          color: Colors.green,
          child: Text('Play', style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white
          ),),
          onPressed: (){
            gameController.gameStatus = Status.mainScreen;
            updateState();
          },
        ),
      ),
    );
  }
}
