import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tankgame/Controllers/controller_status.dart';
import 'package:tankgame/game_controller.dart';

class MoveController extends StatefulWidget {
  final GameController gameController;
  final Function updateState;

  MoveController({this.gameController, this.updateState});
  @override
  _MoveControllerState createState() => _MoveControllerState();
}

class _MoveControllerState extends State<MoveController> {
  bool _buttonPressed = false;
  bool _loopActive = false;

  void _increasePositionWhilePressed() async {
    if (_loopActive) return;
    _loopActive = true;
    while (_buttonPressed) {
      widget.gameController.tank.moveRight(() {
        setState(() {});
      });
      await Future.delayed(Duration(milliseconds: 50));

      _loopActive = false;
    }
  }

  void _decreasePositionWhilePressed() async {
    if (_loopActive) return;
    _loopActive = true;
    while (_buttonPressed) {
      widget.gameController.tank.moveLeft(() {
        setState(() {});
      });
      await Future.delayed(Duration(milliseconds: 50));
    }
    _loopActive = false;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white30,
            Colors.grey[800],
          ],
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
//          SizedBox(
//            width: widget.gameController.tileSize,
//          ),
          Text(
            'Move Panel',
            style: TextStyle(
              fontSize: widget.gameController.tileSize * 1.2,
              fontWeight: FontWeight.bold,
              color: Colors.amberAccent,
            ),
          ),

          SizedBox(width: 30,),

          ButtonTheme(
            minWidth: widget.gameController.tileSize * 1.6,
            child: Container(
              height: (widget.gameController.screenSize.height*0.15),
              child: RaisedButton(
                padding: EdgeInsets.all(0),
                child: Image.asset('assets/images/teleport2.png'),
                onPressed: () {
                  widget.gameController.isTeleport = true;
                  widget.gameController.prevControllerStatus = widget.gameController.controllerStatus;
                  widget.gameController.controllerStatus = ControllerStatus.confirming;
                  print('confirm controller');
                  widget.updateState();
                },
                color: Colors.blue,
                splashColor: Colors.blue[100],
                elevation: widget.gameController.tileSize / 2.5,
                highlightElevation: widget.gameController.tileSize / 12.5,
                animationDuration: Duration(milliseconds: 1000),
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.elliptical(widget.gameController.tileSize*0.48,
                      widget.gameController.tileSize*0.2)),
                ),
              ),
            ),
          ),

          // Left Button
          ButtonTheme(
            minWidth: widget.gameController.tileSize * 1.8,
            child: Container(
              child: RaisedButton(
                padding: EdgeInsets.all(widget.gameController.tileSize / 5),
                child: Listener(
                  onPointerDown: (details) {
                    _buttonPressed = true;
                    _decreasePositionWhilePressed();
                  },
                  onPointerUp: (details) {
                    _buttonPressed = false;
                  },
                  child: Text(
                    '<<',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: widget.gameController.tileSize,
                    ),
                  ),
                ),
                onPressed: () {},
                color: Colors.blue,
                splashColor: Colors.blue[100],
                elevation: widget.gameController.tileSize / 2.5,
                highlightElevation: widget.gameController.tileSize / 12.5,
                animationDuration: Duration(milliseconds: 1000),
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.elliptical(widget.gameController.tileSize*0.48,
                      widget.gameController.tileSize*0.2)),
                ),
              ),
            ),
          ),

//          SizedBox(
//            width: 30,
//          ),

          Text(
            widget.gameController.tank.position.dx.toInt().toString(),
            style: TextStyle(
              color: Colors.grey[350],
              fontWeight: FontWeight.bold,
              fontSize: widget.gameController.tileSize * 0.8,
            ),
          ),

//          SizedBox(
//            width: 30,
//          ),

          // Right Button
          ButtonTheme(
            minWidth: widget.gameController.tileSize * 1.8,
            child: Container(
              child: RaisedButton(
                padding: EdgeInsets.all(widget.gameController.tileSize / 5),
                child: Listener(
                  onPointerDown: (details) {
                    _buttonPressed = true;
                    _increasePositionWhilePressed();
                  },
                  onPointerUp: (details) {
                    _buttonPressed = false;
                  },
                  child: Text(
                    '>>',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: widget.gameController.tileSize,
                    ),
                  ),
                ),
                onPressed: () {},
                color: Colors.blue,
                splashColor: Colors.blue[100],
                elevation: widget.gameController.tileSize / 2.5,
                highlightElevation: widget.gameController.tileSize / 12.5,
                animationDuration: Duration(milliseconds: 1000),
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.elliptical(widget.gameController.tileSize*0.48,
                      widget.gameController.tileSize*0.2)),
                ),
              ),
            ),
          ),
//          Expanded(
//            child: SizedBox(
//              width: 50,
//            ),
//          ),

          // Ok button
          ButtonTheme(
            child: Container(
              child: RaisedButton(
                padding: EdgeInsets.all(widget.gameController.tileSize / 2.5),
                child: Text(
                  'OK',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: widget.gameController.tileSize,
                  ),
                ),
                onPressed: () {
                  widget.gameController.controllerStatus = ControllerStatus.main;
                  print('return to main controller');
                  widget.updateState();
                },
                color: Colors.blue,
                splashColor: Colors.blue[100],
                elevation: widget.gameController.tileSize / 2.5,
                highlightElevation: widget.gameController.tileSize / 12.5,
                animationDuration: Duration(milliseconds: 1000),
                shape: CircleBorder(),
              ),
            ),
          ),
//          SizedBox(
//            width: 50,
//          ),
        ],
      ),
    );
  }
}
