import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tankgame/Controllers/controller_status.dart';
import 'package:tankgame/Shield/SuperShield.dart';
import 'package:tankgame/Shield/normalShield.dart';
import 'package:tankgame/Shield/strongShield.dart';
import 'package:tankgame/Shield/weakShield.dart';
import 'package:tankgame/game_controller.dart';

class BuffController extends StatefulWidget {
  final GameController gameController;
  final Function updateState;

  BuffController({this.gameController, this.updateState});
  @override
  _BuffControllerState createState() => _BuffControllerState();
}

class _BuffControllerState extends State<BuffController> {
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
          ButtonTheme(
            minWidth: widget.gameController.tileSize * 1.8,
            child: Container(
              height: (widget.gameController.screenSize.height*0.15),
              child: RaisedButton(
                padding: EdgeInsets.all(1),
                child: Icon(Icons.add),
                onPressed: () {
                  _increaseHealth();
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

          ButtonTheme(
            minWidth: widget.gameController.tileSize * 1.8,
            child: Container(
              height: (widget.gameController.screenSize.height*0.15),
              child: RaisedButton(
                padding: EdgeInsets.all(1),
                child: Image.asset('assets/images/weak.png'),
                onPressed: () {
                  applyShield(1);
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
//          SizedBox(width: 50.0,),
          ButtonTheme(
            minWidth: widget.gameController.tileSize * 1.8,
            child: Container(
              height: (widget.gameController.screenSize.height*0.15),
              child: RaisedButton(
                padding: EdgeInsets.all(1),
                child: Image.asset('assets/images/normal.png'),
                onPressed: () {
                  applyShield(2);
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
//          SizedBox(width: 50.0,),
          ButtonTheme(
            minWidth: widget.gameController.tileSize * 1.8,
            child: Container(
              height: (widget.gameController.screenSize.height*0.15),
              child: RaisedButton(
                padding: EdgeInsets.all(widget.gameController.tileSize / 10.0),
                child: Image.asset('assets/images/strong.png'),
                onPressed: () {
                  applyShield(3);
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

          ButtonTheme(
            minWidth: widget.gameController.tileSize * 1.8,
            child: Container(
              height: (widget.gameController.screenSize.height*0.15),
              child: RaisedButton(
                padding: EdgeInsets.all(widget.gameController.tileSize / 10.0),
                child: Image.asset('assets/images/super.png'),
                onPressed: () {
                  applyShield(4);
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
//          SizedBox(width: 50.0,),

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

        ],
      ),
    );
  }


  void _increaseHealth() {
    print('Health Increased');
  }


  void applyShield(int level) {
    if(widget.gameController.tank.shieldDetails == null) {
      widget.gameController.isShieldSelection = true;
      widget.gameController.tank.setShield(level);
      widget.gameController.prevControllerStatus = widget.gameController.controllerStatus;
      widget.gameController.controllerStatus = ControllerStatus.confirming;
      print('confirm controller');
      widget.updateState();
    }
    else {
      widget.gameController.isShieldSelection = false;
      if(level == 1) {
        if((widget.gameController.tank.shieldDetails) is WeakShield) {
          print('Already applied');
        } else {
          widget.gameController.prevControllerStatus = widget.gameController.controllerStatus;
          widget.gameController.controllerStatus = ControllerStatus.confirming;
          print('confirm controller');
          widget.updateState();
        }
      } else if(level == 2) {
        if((widget.gameController.tank.shieldDetails) is NormalShield) {
          print('Already applied');
        } else {
          widget.gameController.prevControllerStatus = widget.gameController.controllerStatus;
          widget.gameController.controllerStatus = ControllerStatus.confirming;
          print('confirm controller');
          widget.updateState();
        }
      } else if(level == 3) {
        if((widget.gameController.tank.shieldDetails) is StrongShield) {
          print('Already applied');
        } else {
          widget.gameController.prevControllerStatus = widget.gameController.controllerStatus;
          widget.gameController.controllerStatus = ControllerStatus.confirming;
          print('confirm controller');
          widget.updateState();
        }
      } else if(level == 4) {
        if((widget.gameController.tank.shieldDetails) is SuperShield) {
          print('Already applied');
        } else {
          widget.gameController.prevControllerStatus = widget.gameController.controllerStatus;
          widget.gameController.controllerStatus = ControllerStatus.confirming;
          print('confirm controller');
          widget.updateState();
        }
      }
    }
  }

}
