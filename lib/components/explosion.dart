import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tankgame/game_controller.dart';

import 'Tank.dart';

class Explosion {
  final GameController gameController;
  double radius;
  double currentRadius = 0.0;
  final Offset position;
  Paint paint;
  double time = 0.0;
  bool flag = false;
  final Function function;
  Function calculateVelocity;
  double damageFactor;
  double incr = 6.0;
  Explosion({this.gameController, this.position, this.function, this.calculateVelocity, this.radius=60.0, this.damageFactor = 1.0}) {
    if(calculateVelocity == null) {
      calculateVelocity = (Tank tank){
        return (gameController.tank.canonPosition - Offset(tank.position.dx, tank.temp - tank.imageSize.y / 2)).distance.abs() / gameController.fireBall.time;
      };
    }
    paint = Paint();
    currentRadius = 0.0;
  }

  void render(Canvas canvas){


    Gradient gradient = RadialGradient(
      center: const Alignment(0.0, 0.0), // near the top right
      radius: 1,
      colors: [
        Colors.orange[900],
        Colors.orange[800],
        Colors.orange[700],
        Colors.orange[600],
        Colors.orange[500],
        Colors.orange[400],
        Colors.orange[300],
        Colors.orange[200],
        Colors.orange[100],
        Colors.orange[50]
      ],
      stops: [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0],
    );
    paint = new Paint()..shader = gradient.createShader(Rect.fromCenter(center: position, width: currentRadius, height: currentRadius));
    canvas.drawOval(Rect.fromCenter(center: position, width: currentRadius, height: currentRadius), paint);
  }

  void update(double t) {
    if(currentRadius >= radius) {
      gameController.mountain.cutMountain(position, radius);
      flag = true;
      calculateDamage();
    }


    currentRadius += flag ? -incr : incr/2;

    if(currentRadius <= -1) {
      currentRadius = 0.0;
      incr = 0;
      function();

    }

  }

  void calculateDamage(){

    gameController.tanks.forEach((Tank tank){
      if(tank.alive) {
        Offset center = Offset(tank.position.dx, tank.temp - tank.imageSize.y / 2);
        double tankWidth = (tank.shieldDetails == null ? tank.imageSize.y / 2 : gameController.tileSize + (gameController.tileSize) / 5);
        double distance = (center - position).distance.abs() - tankWidth;


        if(distance < radius) {
          double intensity = 1 - (distance / radius);
          double velocity = calculateVelocity(tank);
          double damage = intensity * (20 + velocity) * gameController.tank.tankPower.energy * damageFactor;
          print('tank: ${tank.color},damage: $damage ');
          tank.damageDealt(damage);
        }
      }
    });
  }

}