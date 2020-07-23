import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tankgame/Controllers/controller_status.dart';
import 'package:tankgame/components/fireball/Ball.dart';
import 'package:tankgame/components/fireball/fire_ball.dart';
import 'package:tankgame/components/mountain_generator.dart';
import 'package:tankgame/components/wind_display.dart';

import 'cloud_spawner.dart';
import 'components/Tank.dart';
import 'components/cloud.dart';
import 'components/game_status.dart';
import 'components/wind.dart';

class GameController extends BaseGame {
  final SharedPreferences storage;
  Size screenSize;
  Size playScreenSize;
  double playScreenHeightRation;
  Status gameStatus;
  double tileSize;
  List<Tank> tanks;
  bool fired;
  Ball fireBall;
  Tank tank;
  Wind wind;
  WindDisplay windDisplay;
  int turn = 0;
  Mountain mountain;
  int noOfPlayer = 2;
  
  int alivePlayer;
  List<Cloud> clouds = List<Cloud>();
  CloudSpawner cloudSpawner;

// This is for Controller
  ControllerStatus controllerStatus;
  ControllerStatus prevControllerStatus;
  int angle;
  int power;
  Function updateControllerState;
  bool isTeleport;
  bool isShieldSelection;
  Offset teleportPosition;

  GameController(this.storage, this.screenSize){
    initiate();
  }
  void initiate() async{
    gameStatus = Status.menu;
    playScreenHeightRation = 0.8;
    playScreenSize = Size(screenSize.width, screenSize.height*playScreenHeightRation);
    tileSize = playScreenSize.width / 25;
    mountain = Mountain(this);
    fired = false;
    fireBall = FireBall(gameController: this, initialPosition: (Offset(-10.0,-10.0)));

    cloudSpawner = CloudSpawner(this);
    wind = Wind();
    controllerStatus = ControllerStatus.main;
    windDisplay = WindDisplay(this);
    tanks = List<Tank>();

    tanks.add(Tank(gameController: this, color: 'amber'));
    tanks.add(Tank(gameController: this, color: 'blue'));
    tanks.add(Tank(gameController: this, color: 'green'));
    tank = tanks[turn];
    alivePlayer = tanks.length;

  }

  void render(Canvas canvas) {
    drawBackground(canvas);	
	
	clouds.forEach((Cloud cloud) => cloud.render(canvas));
	
    drawMountain(canvas);	
    mountain.render(canvas);	
    fireBall.render(canvas);	
    windDisplay.render(canvas);	
    tanks.forEach((Tank tank){
      if(tank.alive)
        tank.render(canvas);
    });
    if(isTeleport == true && teleportPosition != null) {
      drawTelePos(canvas);
    }

  }

  void update(double t) {
    if(fired)
      fireBall.update(t);
    windDisplay.update(t);
    mountain.update(t);
    tank.update(t);
    tanks.forEach((Tank tank){
      tank.update(t);
    });
    cloudSpawner.update(t);
    clouds.forEach((Cloud cloud) => cloud.update(t));
    for (int i = 0; i < clouds.length; i++) {
      if (clouds[i].isDead) clouds.removeAt(i);
    }
  }

  void drawBackground(Canvas canvas) {
    Rect rect = Rect.fromLTWH(0, 0, playScreenSize.width,
        playScreenSize.height);
    Gradient gradient = LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomRight,
        colors: [Colors.black, Colors.deepPurple[900]]);
    Paint paint = new Paint()..shader = gradient.createShader(rect);
    canvas.drawRect(rect, paint);
  }
  void drawMountain(Canvas canvas) {
    Rect rect = Rect.fromLTWH(0, 0, playScreenSize.width,
        playScreenSize.height);
    Paint linePaint = Paint();

    Gradient gradient = LinearGradient(
        begin: Alignment.bottomRight,
        end: Alignment.bottomLeft,
        colors: [Color(0xff3a9452), Colors.green[400]]);
    linePaint.shader = gradient.createShader(rect);
    Paint paint = Paint()..color = Colors.white;

    for(int i=0; i<mountain.points.length;i++) {

      canvas.drawLine(mountain.points[i], Offset(mountain.points[i].dx, playScreenSize.height),
          linePaint);
    }
    canvas.drawPoints(PointMode.polygon, mountain.points, paint);
  }

  void drawTelePos(Canvas canvas) {
    Offset myPos = Offset(teleportPosition.dx , mountain.points[teleportPosition.dx.toInt()].dy);
    Rect rect = Rect.fromCircle(center: myPos, radius: tileSize / 5);
    Paint paint = new Paint()..color = Colors.grey;
    canvas.drawOval(rect, paint);
  }

  
  void onTapDown(TapDownDetails d) {
    if(controllerStatus == ControllerStatus.confirming && isTeleport == true) {
      print(d.globalPosition);
      if(d.globalPosition.dy <= playScreenSize.height) {
        teleportPosition = d.globalPosition;
      }
    }
  }
  
  void nextTurn() {
    if(alivePlayer <= 1) {
      gameOver();
    } else {
      turn = (turn + 1) % tanks.length;
      tank = tanks[turn];
      if(!tank.alive)
        nextTurn();
    }
    updateControllerState();
  }
  
  void gameOver() {
    print('Winner: ${tank.color}');
  }

}

