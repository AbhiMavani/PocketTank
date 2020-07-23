import 'package:flame/flame.dart';
import 'package:flame/util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Screen/screen_controller.dart';
import 'game_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Util flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientations([DeviceOrientation.landscapeLeft,DeviceOrientation.landscapeRight]);
  Size size = await Flame.util.initialDimensions();
  SharedPreferences storage = await SharedPreferences.getInstance();
  GameController gameController = GameController(storage, size);
  TapGestureRecognizer tapper = TapGestureRecognizer();
  tapper.onTapDown = gameController.onTapDown;
  flameUtil.addGestureRecognizer(tapper);

  runApp(GameWidget(gameController: gameController));
}

class GameWidget extends StatefulWidget {
  final GameController gameController;

  const GameWidget({Key key, this.gameController}) : super(key: key);

  @override
  _GameWidgetState createState() => _GameWidgetState();
}

class _GameWidgetState extends State<GameWidget> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft,DeviceOrientation.landscapeRight]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tanks',
      home: Scaffold(
          body: Controller(gameController: widget.gameController,)
      ),
    );
  }
}


