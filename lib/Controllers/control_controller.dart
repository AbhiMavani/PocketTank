import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tankgame/Controllers/angle_controller.dart';
import 'package:tankgame/Controllers/buff_controller.dart';
import 'package:tankgame/Controllers/confirm_controller.dart';
import 'package:tankgame/Controllers/controller_status.dart';
import 'package:tankgame/Controllers/main_controller.dart';
import 'package:tankgame/Controllers/move_controller.dart';
import 'package:tankgame/Controllers/power_controller.dart';
import 'package:tankgame/game_controller.dart';

class ControllerMenu extends StatefulWidget {
  final GameController gameController;
  ControllerMenu(this.gameController);

  @override
  _ControllerMenuState createState() => _ControllerMenuState();
}

class _ControllerMenuState extends State<ControllerMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[850],
      child: getWidget(),
    );
  }

  Widget getWidget() {
    Widget myControl;
    ControllerStatus controllerStatus = widget.gameController.controllerStatus;
    print(controllerStatus);
    if(controllerStatus == ControllerStatus.main) {
      myControl = MainController(gameController: widget.gameController, updateState: updateState);
    } else if(controllerStatus == ControllerStatus.move) {
      myControl = MoveController(gameController: widget.gameController, updateState: updateState);
    } else if(controllerStatus == ControllerStatus.angle) {
      myControl = AngleController(gameController: widget.gameController, updateState: updateState,);
    } else if(controllerStatus == ControllerStatus.power) {
      myControl = PowerController(gameController: widget.gameController, updateState: updateState);
    } else if(controllerStatus == ControllerStatus.buff) {
      myControl = BuffController(gameController: widget.gameController, updateState: updateState);
    } else if(controllerStatus == ControllerStatus.confirming) {
      myControl = ConfirmController(gameController: widget.gameController, updateState: updateState);
    }
    return myControl;
  }


  void updateState() {
    setState(() {});
  }

}


