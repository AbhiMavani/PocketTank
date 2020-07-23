import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tankgame/Controllers/controller_status.dart';
import 'package:tankgame/components/weapons.dart';
import 'package:tankgame/game_controller.dart';

class MainController extends StatefulWidget {
  final GameController gameController;
  final Function updateState;

  MainController({this.gameController, this.updateState}) {
    gameController.updateControllerState = updateState;
  }

  @override
  _MainControllerState createState() => _MainControllerState();
}

class _MainControllerState extends State<MainController> {
  Weapon firstWeapon = weapons.first;

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
          getMoveWidget(),
//            SizedBox(width: widget.gameController.tileSize,),
          getWeaponButton(),
          getFireButton(),
          getAngleButton(),
          getPowerButton(),
          getBuffButton(),
        ],
      ),
    );
  }

  Widget getMoveWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Move',
          style: TextStyle(
            fontSize: widget.gameController.tileSize * 0.4,
            fontWeight: FontWeight.bold,
            color: Colors.grey[900],
          ),
        ),
        ButtonTheme(
          minWidth: widget.gameController.tileSize * 1.4,
          child: Container(
            child: RaisedButton(
              padding: EdgeInsets.all(1.0),
              child: Icon(
                Icons.track_changes,
                color: Colors.black,
              ),
              onPressed: () {
                widget.gameController.controllerStatus = ControllerStatus.move;
                widget.updateState();
              },
              color: Colors.blue,
              splashColor: Colors.blue[100],
              elevation: (widget.gameController.tileSize/2.5),
              highlightElevation: (widget.gameController.tileSize/12.5),
              animationDuration: Duration(milliseconds: 1000),
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.all(Radius.elliptical(widget.gameController.tileSize*0.48,
                    widget.gameController.tileSize*0.2)),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget getWeaponButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Weapon',
          style: TextStyle(
            fontSize: widget.gameController.tileSize * 0.4,
            fontWeight: FontWeight.bold,
            color: Colors.grey[900],
          ),
        ),
        Container(
          color: Colors.blue,
          padding: EdgeInsets.all(widget.gameController.tileSize / 3),
          child: ButtonTheme(
            child: DropdownButton<Weapon>(
              value: firstWeapon,
              icon: Icon(Icons.arrow_drop_up),
              iconSize: widget.gameController.tileSize * 0.8,
              elevation: (widget.gameController.tileSize * 0.4).toInt(),
              onChanged: (Weapon newValue) {
                setState(() {
                  int ind = weapons.indexWhere((Weapon weapon) => (weapon == newValue));
                  if(ind >= 0) {
                    firstWeapon = weapons[ind];
                    widget.gameController.tank.selectedWeapon = firstWeapon.name;
                  }

                });
              },
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: widget.gameController.tileSize * 0.7,
              ),
              underline: Container(
                height: 0,
              ),
              isDense: true,
              items: weapons.map<DropdownMenuItem<Weapon>>((Weapon value) {
                String image = 'assets/images/${value.img}';
                return DropdownMenuItem<Weapon> (
                  value: value,
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                          image,
                          height: widget.gameController.tileSize * 0.7,
                          width: widget.gameController.tileSize * 0.7,
                        ),
                        SizedBox(width: widget.gameController.tileSize * 0.4),
                        Text(
                          "${value.name}",
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
//        SizedBox(height: 1,),
      ],
    );
  }

  Widget getFireButton() {
    return Container(
      child: ButtonTheme (
        minWidth: widget.gameController.tileSize * 6,
        height: widget.gameController.tileSize * 2.0,
        child: Container(
          child: RaisedButton(
            padding: EdgeInsets.all(1.0),
            child: Text(
              'FIRE',
              style: TextStyle(
                color: Colors.black,
                fontSize: widget.gameController.tileSize * 1.2,
              ),
            ),
            onPressed: widget.gameController.tank.fire ,
            color: Colors.blue,
            splashColor: Colors.blue[100],
            elevation: (widget.gameController.tileSize/2.5),
            highlightElevation: (widget.gameController.tileSize/12.5),
            animationDuration: Duration(milliseconds: 1000),
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.all(Radius.elliptical(widget.gameController.tileSize*0.48,
                  widget.gameController.tileSize*0.3)),
            ),
          ),
        ),
      ),
    );
  }

  Widget getAngleButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Angle',
          style: TextStyle(
            fontSize: widget.gameController.tileSize * 0.4,
            fontWeight: FontWeight.bold,
            color: Colors.grey[900],
          ),
        ),
        ButtonTheme(
          minWidth: widget.gameController.tileSize * 2.0,
          child: Container(
            child: RaisedButton(
              padding: EdgeInsets.all(1.0),
              child: Text(
                (widget.gameController.tank.fireDetails.angle * 180 ~/ 3.14).toString(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: widget.gameController.tileSize * 0.75,
                ),
              ),
              onPressed: () {
                widget.gameController.controllerStatus = ControllerStatus.angle;
                widget.updateState();
              },
              color: Colors.blue,
              splashColor: Colors.blue[100],
              elevation: (widget.gameController.tileSize/2.5),
              highlightElevation: (widget.gameController.tileSize/12.5),
              animationDuration: Duration(milliseconds: 1000),
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.all(Radius.elliptical(widget.gameController.tileSize*0.48,
                    widget.gameController.tileSize*0.2)),
              ),

            ),
          ),
        ),
      ],
    );
  }

  Widget getPowerButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Power',
          style: TextStyle(
            fontSize: widget.gameController.tileSize * 0.4,
            fontWeight: FontWeight.bold,
            color: Colors.grey[900],
          ),
        ),
        ButtonTheme(
          minWidth: widget.gameController.tileSize * 2.0,
          child: Container(
            child: RaisedButton(
              padding: EdgeInsets.all(1.0),
              child: Text(
                widget.gameController.tank.fireDetails.power.toInt().toString(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: widget.gameController.tileSize * 0.75,
                ),
              ),
              onPressed: () {
                widget.gameController.controllerStatus = ControllerStatus.power;
                widget.updateState();
              },
              color: Colors.blue,
              splashColor: Colors.blue[100],
              elevation: (widget.gameController.tileSize/2.5),
              highlightElevation: (widget.gameController.tileSize/12.5),
              animationDuration: Duration(milliseconds: 1000),
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.all(Radius.elliptical(widget.gameController.tileSize*0.48,
                    widget.gameController.tileSize*0.2)),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget getBuffButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Buff',
          style: TextStyle(
            fontSize: widget.gameController.tileSize * 0.4,
            fontWeight: FontWeight.bold,
            color: Colors.grey[900],
          ),
        ),
        ButtonTheme(
          minWidth: widget.gameController.tileSize * 1.4,
          child: Container(
            child: RaisedButton(
              padding: EdgeInsets.all(2.0),
              child: Icon(
                Icons.star_half,
              ),
              onPressed: () {
                widget.gameController.controllerStatus = ControllerStatus.buff;
                widget.updateState();
              },
              color: Colors.blue,
              splashColor: Colors.blue[100],
              elevation: (widget.gameController.tileSize/2.5),
              highlightElevation: (widget.gameController.tileSize/12.5),
              animationDuration: Duration(milliseconds: 1000),
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.all(Radius.elliptical(widget.gameController.tileSize*0.48,
                    widget.gameController.tileSize*0.2)),
              ),

            ),
          ),
        ),
      ],
    );
  }


}



