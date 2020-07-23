import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tankgame/components/explosion.dart';
import 'package:tankgame/components/fire_details.dart';
import 'package:tankgame/components/fireball/Ball.dart';
import 'package:tankgame/game_controller.dart';

import '../Tank.dart';

class FireBall extends Ball{
  final GameController gameController;
  Offset initialPosition;
  Offset position;
  Paint paint;
  Rect rect;
  double radius;
  double powerFactor = 0.8;
  FireDetails fireDetails = FireDetails( angle: 0.0, power: 0.0);  //firePosition: Offset.zero,
  double time;
  bool exploded = false;
  Explosion explosion;
  FireBall({this.gameController, this.initialPosition, this.fireDetails}) {
    position = initialPosition;
    paint = Paint()..color = Colors.white;
    radius = 5;
    time = 0.0;
  }

  void render(Canvas canvas) {
    if(!exploded) {
      rect = Rect.fromCenter(center: position, width: radius, height: radius);
      canvas.drawOval(rect, paint);
    } else {
      renderExplosion(canvas);

    }

  }

  void update(double t) {

    if(!exploded) {

      gameController.tanks.forEach((Tank tank){
        if(tank.alive) {
          if(tank.contain(position)) {
           setExplode();

          }
        }
      });
      if(!exploded) {
        try{
          if(position.dx <= 0 && position.dx >= gameController.mountain.points.length) {
            position = Offset(-10, -10);
            gameController.fired = false;
            gameController.nextTurn();
            gameController.wind.updateWind();

          } else if(position.dy >= gameController.playScreenSize.height
              || position.dy >= gameController.mountain.points[position.dx.toInt()].dy) {
            if(explosion == null) {
              setExplode();
            }

          } else {
            updatePosition(t);
          }
        } catch(e) {
          print(e);
          gameController.fired = false;
          gameController.nextTurn();
          position = Offset(-10.0,-10.0);
          gameController.wind.updateWind();
        }
      }

    } else {
      updateExplosion(t);
    }
  }

  void updatePosition(double t) {
    time += 0.15;
//  time = t;
//    powerFactor = 0.8;
    double dx = initialPosition.dx + powerFactor *  fireDetails.power * cos(fireDetails.angle) * time + 0.04 * gameController.wind.windPower * time * time;
    double dy = initialPosition.dy - powerFactor * fireDetails.power * sin(fireDetails.angle) * time  +  0.5 * gameController.wind.gravity * time * time;
    if(dy >= gameController.mountain.points[dx.toInt()].dy ) {
      time -= 0.1;
      dx = initialPosition.dx + powerFactor *  fireDetails.power * cos(fireDetails.angle) * time + 0.04 * gameController.wind.windPower * time * time;
      dy = initialPosition.dy - powerFactor * fireDetails.power * sin(fireDetails.angle) * time  +  0.5 * gameController.wind.gravity * time * time;
      setExplode();
    }
    position = Offset(dx, dy);
  }

  void setExplode() {
    exploded = true;
    explosion = Explosion(gameController: gameController,  position: position, radius: gameController.tileSize * 2,function: (){
      this.exploded = false;
      gameController.nextTurn();
      gameController.fired = false;
      gameController.fireBall.position = Offset(-10, -10);
    });
  }
  void renderExplosion(Canvas canvas) {
    explosion.render(canvas);
  }
  void updateExplosion(double t) {
    explosion.update(t);
  }



}
