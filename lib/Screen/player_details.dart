import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:tankgame/components/Tank.dart';
import 'package:tankgame/components/game_status.dart';
import 'package:tankgame/game_controller.dart';

import 'gameMode.dart';

class PlayerDetails extends StatefulWidget {
  final GameController gameController;
  final Function updateState;
  final _formKey = GlobalKey<FormState>();
  TextEditingController textController = TextEditingController();
  TankColor tankColor;
  List<TankColor> colorForTank;
  int temp;
  String playerName;
  String color;
  bool viewVisible;
  Color colorSelected;
  PlayerDetails({Key key, this.gameController, this.updateState}) {
    temp = 1;
    playerName = "Enter Your Name";
    viewVisible = false;
    colorForTank = TankColor.getColors();
    for (TankColor tankcolor in colorForTank) {
      tankcolor.selectedColor = true;
    }
  }

  @override
  _PlayerDetailsState createState() => _PlayerDetailsState();
}

class _PlayerDetailsState extends State<PlayerDetails> {

  void setTankColor(String colorName) {
    widget.color = colorName;
  }

  bool setName() {
    String text = widget.textController.text;

    if(text == '')
      return false;
    else{
      widget.playerName = text;
      print(widget.playerName);
      return true;
    }

  }

  void showWidget() {
    setState(() {
      widget.viewVisible = true;
    });

  }


  void storeData() async {
    if (widget.gameController.noOfPlayer == widget.temp) {
      widget.gameController.gameStatus = Status.playing;
      widget.updateState();
    }

    for (TankColor tankColor in widget.colorForTank) {
      if (tankColor.colorName == widget.color)
        widget.colorForTank.remove(tankColor);
    }

    Tank tank = Tank(
        gameController: widget.gameController,
        playerName: widget.playerName,
        color: widget.color);
    widget.gameController.tanks.add(tank);


  }

  List<Widget> getButton() {
    List<Widget> widgets = [];

    for (TankColor tankcolor in widget.colorForTank) {
      if (tankcolor.selectedColor == true) {
        widgets.add(
          ButtonTheme(
            minWidth: widget.gameController.tileSize * 1.367187,
            child: RaisedButton(
              padding: EdgeInsets.all(widget.gameController.tileSize * 0.17089),
              autofocus: true,
              focusElevation: widget.gameController.tileSize * 0.06835,
              onPressed: () {
                setTankColor(tankcolor.colorName);
                widget.colorSelected = tankcolor.color;

                showWidget();

              },
              color: tankcolor.color,
              splashColor: Colors.blue[100],
              elevation: widget.gameController.tileSize * 0.034179,
              highlightElevation: widget.gameController.tileSize * 0.06835,
              animationDuration: Duration(milliseconds: 1000),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.elliptical(
                    widget.gameController.tileSize * 0.410156,
                    widget.gameController.tileSize * 0.341796)),
              ),
            ),
          ),
        );
      }
    }

    return widgets;
  }

  Widget userDetailsUi(int number) {
    Widget widgets;
    widgets = GradientCard(
      gradient: Gradients.tameer,
      shadowColor: Gradients.tameer.colors.last
          .withOpacity(widget.gameController.tileSize * 0.008544),
      elevation: widget.gameController.tileSize * 0.273437,
      child: Container(
        margin: new EdgeInsets.fromLTRB(
            widget.gameController.tileSize * 6.015624,
            widget.gameController.tileSize * 1.025390,
            widget.gameController.tileSize * 5.468749,
            widget.gameController.tileSize * 2.050781),
        constraints: BoxConstraints.expand(),
        child: SingleChildScrollView(
          child: Form(
            key: widget._formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Player $number",
                  style: TextStyle(
                    fontSize: widget.gameController.tileSize * 1.025390,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: widget.gameController.tileSize * 0.341796,
                ),
                TextField(
                  onTap: () => SystemChrome.restoreSystemUIOverlays(),
                  autofocus: true,
                  autocorrect: true,
                  cursorColor: Colors.black,
                  cursorWidth: widget.gameController.tileSize * 0.17089,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    focusColor: Colors.black,
                    hintText: "${widget.playerName}",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          widget.gameController.tileSize * 0.17089),
                      borderSide: BorderSide(
                        color: Colors.amber,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                  controller: widget.textController,
                  maxLines: 1,
                  maxLength: 15,
                  toolbarOptions: ToolbarOptions(
                    cut: true,
                    copy: true,
                    selectAll: true,
                    paste: true,
                  ),

                  style: TextStyle(
                    color: Colors.black,
                    fontSize: widget.gameController.tileSize * 1.02539,
                  ),
                ),
                SizedBox(
                  height: widget.gameController.tileSize * 0.8,
                ),
                Container(
                  height: widget.gameController.tileSize * 0.683593,
                  child: Row(children: getButton()),
                ),
                SizedBox(
                  height: widget.gameController.tileSize * 0.8,
                ),

                showTankColor(viewVisible: widget.viewVisible,selectedColor: widget.colorSelected,gameController: widget.gameController,),
                SizedBox(
                  height: widget.gameController.tileSize * 0.5,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      "NextPlayer",
                      style: TextStyle(
                        fontSize: widget.gameController.tileSize * 1.02539,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: widget.gameController.tileSize * 3.45976,
                    ),

                    ///110
                    RaisedButton.icon(
                      onPressed: () {
//                      print(widget
//                          .gameController.player_details.selectedTankColor);
//                      print(widget.gameController.player_details.playerName);
//
//                      print(widget.gameController.player_details.noOfPlayer);
                        if (setName()) {
                          print(widget.color);
                          if (widget.color == null) {
                            Scaffold.of(context).showSnackBar(
                                SnackBar(content: Text('Press Tank Color')));
                          } else {
                            storeData();
                            setState(() {
                              widget.temp++;
                              widget.viewVisible = false;
                              widget.playerName = "Enter Your Name ";
                              widget.textController.clear();
                              widget.color = null;
                              widget.colorSelected = null;
                              userDetailsUi(widget.temp);
                            });
                          }
                        }
                        else{
                          Scaffold.of(context).showSnackBar(
                              SnackBar(content: Text('Name Is Required')));
                        }
                      },
                      icon: Icon(Icons.arrow_forward),
                      label: Text(
                        "Next",
                        style: TextStyle(
                          fontSize: widget.gameController.tileSize * 1.025388,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      color: Colors.blueGrey,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      body: Container(
        child: userDetailsUi(widget.temp),
      ),
    );
  }
}


class showTankColor extends StatefulWidget {
  bool viewVisible;
  final GameController gameController;
  Color selectedColor;


  showTankColor({Key key, this.gameController, this.viewVisible,this.selectedColor});
  @override
  _showTankColorState createState() => _showTankColorState();
}

class _showTankColorState extends State<showTankColor> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Visibility(
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          visible: widget.viewVisible,
          child: Row(
            children: <Widget>[
              Text(
                "TankColor",
                style: TextStyle(
                  fontSize: widget.gameController.tileSize * 0.9,
                  color:widget.selectedColor,
                ),
              ),
              SizedBox(
                width: widget.gameController.tileSize * 1.0,
              ),
              Container(
                height: 15,
                width: 15,
                color: widget.selectedColor,
                // margin: EdgeInsets.only(top: 0, bottom: 30),
              )
            ],
          ),
        ),

      ],
    );
  }
}

