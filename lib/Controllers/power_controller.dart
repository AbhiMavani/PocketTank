import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tankgame/Controllers/controller_status.dart';
import 'package:tankgame/game_controller.dart';

class PowerController extends StatefulWidget {
  final GameController gameController;
  final Function updateState;

  PowerController({this.gameController, this.updateState});
  @override
  _PowerControllerState createState() => _PowerControllerState();
}

class _PowerControllerState extends State<PowerController> {

  bool _buttonPressed = false;
  bool _loopActive = false;


  void _increasePowerWhilePressed() async {
    if (_loopActive) return;
    _loopActive = true;
    while (_buttonPressed && widget.gameController.tank.fireDetails.power < 100) {
      setState(() {
        widget.gameController.tank.fireDetails.power++;
      });
      await Future.delayed(Duration(milliseconds: 200));
    }
    _loopActive = false;
  }

  void _decreasePowerWhilePressed() async {
    if (_loopActive) return;
    _loopActive = true;
    while (_buttonPressed && widget.gameController.tank.fireDetails.power > 0) {
      setState(() {
        widget.gameController.tank.fireDetails.power--;
      });
      await Future.delayed(Duration(milliseconds: 200));
    }
    _loopActive = false;
  }

  void updatePower(double power) {
    setState(() {});
    widget.gameController.tank.fireDetails.power = power;
  }

  @override
  Widget build(BuildContext context) {
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
          SizedBox(width: widget.gameController.tileSize,),
          Text(
            'Power Panel',
            style: TextStyle(
              fontSize: widget.gameController.tileSize * 1.2,
              fontWeight: FontWeight.bold,
              color: Colors.amberAccent,
            ),
          ),

//          SizedBox(width: 25,),
          getPowerSlider(),
//          SizedBox(width: 25,),

          // Minus Button
          ButtonTheme(
            minWidth: widget.gameController.tileSize * 1.8,
            child: Container(
              child: RaisedButton(
                padding: EdgeInsets.all(widget.gameController.tileSize / 5),
                child: Listener(
                  onPointerDown: (details) {
                    _buttonPressed = true;
                    _decreasePowerWhilePressed();
                  },
                  onPointerUp: (details) {
                    _buttonPressed = false;
                  },
                  child: Text(
                    '-',
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

//          SizedBox(width: 10,),

          Text(
            widget.gameController.tank.fireDetails.power.toInt().toString(),
            style: TextStyle(
              color: Colors.grey[350],
              fontWeight: FontWeight.bold,
              fontSize: widget.gameController.tileSize * 0.8,
            ),
          ),

//          SizedBox(width: 10,),
          // Plus Button
          ButtonTheme(
            minWidth: widget.gameController.tileSize * 1.8,
            child: Container(
              child: RaisedButton(
                padding: EdgeInsets.all(widget.gameController.tileSize / 5),
                child: Listener(
                  onPointerDown: (details) {
                    _buttonPressed = true;
                    _increasePowerWhilePressed();
                  },
                  onPointerUp: (details) {
                    _buttonPressed = false;
                  },
                  child: Text(
                    '+',
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

//          SizedBox(width: 30,),

          // Ok button
          ButtonTheme(
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
//          SizedBox(width: 50,),

        ],
      ),
    );
  }

  Widget getPowerSlider() {
    return Container(
      child: Slider(
        activeColor: Colors.blue,
        inactiveColor: Colors.blue[100],
        value: widget.gameController.tank.fireDetails.power,
        label: widget.gameController.tank.fireDetails.power.toInt().toString(),
        min: 0,
        max: 100,
        divisions: 100,
        onChanged: (double value) {
          updatePower(value);
        },
      ),
    );
  }

}

