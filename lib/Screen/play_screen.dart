import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tankgame/Controllers/control_controller.dart';
import 'package:tankgame/game_controller.dart';

class PlayScreen extends StatelessWidget {
  final GameController gameController;
  final Function updateState;

  const PlayScreen({Key key, this.gameController, this.updateState})
      : super(key: key);


  @override
  Widget build(BuildContext context) {


    return Container(
      child: Column(
        children: <Widget>[
          Container(
            width: gameController.playScreenSize.width,
            height: gameController.playScreenSize.height,
            child: gameController.widget,
          ),
          Expanded(
              child: Container(
                width: gameController.playScreenSize.width,
//                height: gameController.screenSize.height*(0.20),
                child: ControllerMenu(gameController),
              )
          ),

        ],
      ),
    );
  }
}



/*
Container(
              width: gameController.playScreenSize.width,
              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      child: Text(
                        'Fire',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.green,
                      onPressed: gameController.tank.fire,
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    RaisedButton(
                      child: Text(
                        'Stop',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.green,
                      onPressed: () => gameController.fired = false,
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Listener(
                      onPointerDown: (details) {
                        gameController.tank.buttonPressed = true;
                        gameController.tank.moveLeft();
                      },
                      onPointerUp: (details) {
                        gameController.tank.buttonPressed = false;
                      },
                      child: Container(
                        decoration: BoxDecoration(color: Colors.orange, border: Border.all()),
                        padding: EdgeInsets.all(16.0),
                        child: Text('Left'),
                      ),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Listener(
                      onPointerDown: (details) {
                        gameController.tank.buttonPressed = true;
                        gameController.tank.moveRight();
                      },
                      onPointerUp: (details) {
                        gameController.tank.buttonPressed = false;
                      },
                      child: Container(
                        decoration: BoxDecoration(color: Colors.orange, border: Border.all()),
                        padding: EdgeInsets.all(16.0),
                        child: Text('Right'),
                      ),
                    ),
                  ],
                ),
              ))
 */
