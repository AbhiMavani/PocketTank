import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tankgame/components/game_status.dart';
import 'package:tankgame/game_controller.dart';

class HomeScreen extends StatefulWidget {
  final GameController gameController;
  final Function updateState;

  HomeScreen({this.gameController, this.updateState});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _increasePlayerWhilePressed() async {
    if (widget.gameController.noOfPlayer < 6) {
      setState(() {
        int temp = widget.gameController.noOfPlayer;
        temp++;
        widget.gameController.noOfPlayer = temp;
      });
      await Future.delayed(Duration(milliseconds: 200));
    }
  }

  void _decreasePlayerWhilePressed() async {
    if (widget.gameController.noOfPlayer > 2) {
      setState(() {
        int temp = widget.gameController.noOfPlayer;
        temp--;
        widget.gameController.noOfPlayer = temp;
      });
      await Future.delayed(Duration(milliseconds: 200));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'PLAYERS',
            style: TextStyle(
              fontSize: widget.gameController.tileSize * 2.0253,
              fontWeight: FontWeight.bold,
              color: Colors.amberAccent,
            ),
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: widget.gameController.tileSize * 9.612084,
              ),

              Padding(
                padding:
                    EdgeInsets.all(widget.gameController.tileSize * 0.341796),
                child: ButtonTheme(
                  minWidth: widget.gameController.tileSize * 1.3671875,
                  child: RaisedButton(
                    child: Text(
                      '-',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: widget.gameController.tileSize * 0.854492,
                      ),
                    ),
                    onPressed: () {
                      // _buttonPressed = true;
                      _decreasePlayerWhilePressed();
                    },
                    color: Colors.blue,
                    splashColor: Colors.blue[100],
                    elevation: widget.gameController.tileSize * 0.341796,
                    highlightElevation: 2,
                    animationDuration: Duration(milliseconds: 1000),
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.elliptical(
                          widget.gameController.tileSize * 0.410156,
                          widget.gameController.tileSize * 0.341796)),
                    ),
                  ),
                ),
              ),
              Text(
                "${widget.gameController.noOfPlayer}",
                style: TextStyle(
                    fontSize: widget.gameController.tileSize * 1.0253906,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              ),
              Padding(
                padding:
                    EdgeInsets.all(widget.gameController.tileSize * 0.341796),
                child: ButtonTheme(
                  minWidth: widget.gameController.tileSize * 1.3671875,
                  child: RaisedButton(
                    child: Text(
                      '+',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: widget.gameController.tileSize * 0.854492,
                      ),
                    ),
                    onPressed: () {
                      _increasePlayerWhilePressed();
                    },
                    color: Colors.blue,
                    splashColor: Colors.blue[100],
                    elevation: widget.gameController.tileSize * 0.341796,
                    highlightElevation: 2,
                    animationDuration: Duration(milliseconds: 1000),
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.elliptical(
                          widget.gameController.tileSize * 0.410156,
                          widget.gameController.tileSize * 0.341796)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: widget.gameController.tileSize * 5.01054,
              ), // 170
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 230.0 , 0.0, 10.0),
                child: ButtonTheme(
                  minWidth: widget.gameController.tileSize * 1.367187,
                  child: RaisedButton(
                    child: Text(
                      'PLAY',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: widget.gameController.tileSize * 0.854492,
                      ),
                    ),
                    onPressed: () {
                      widget.gameController.gameStatus = Status.playerDetails;
                      print("return playerDetails");
                      widget.updateState();
                    },
                    color: Colors.blue,
                    splashColor: Colors.blue[100],
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.elliptical(
                          widget.gameController.tileSize * 0.410156,
                          widget.gameController.tileSize * 0.341796)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
