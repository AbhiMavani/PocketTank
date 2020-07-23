import 'dart:ui';

import 'package:tankgame/components/fireball/fire_ball.dart';

import '../Tank.dart';
import '../explosion.dart';

class LargeBall extends FireBall {

  bool isTank = false;
  double maxMovement;
  double curMovement;
  double maxRadius;

  LargeBall({gameController, initialPosition, fireDetails}) : super(gameController: gameController,initialPosition: initialPosition, fireDetails: fireDetails) {
    maxMovement = gameController.tileSize*1.5;
    curMovement = 0.0;
    maxRadius = gameController.tileSize*2.5;
  }

  void setExplode() {

    gameController.tanks.forEach((Tank tank){
      if(tank.alive) {
        if(tank.contain(Offset(position.dx, position.dy - tank.imageSize.y/3))
          || tank.contain(Offset(position.dx, position.dy))) {
          print('tank on explosion position');
          isTank = true;
        }
      }
    });
    if(isTank) {
      exploded = true;
      explosion = Explosion(
          gameController: gameController,
          position: position,
          radius: maxRadius,
          damageFactor: 1.0 - (curMovement/maxMovement)*0.25,
          function: () {
            this.exploded = false;
            gameController.nextTurn();
            gameController.fired = false;
            gameController.fireBall.position = Offset(-10,-10);
          }
      );
    } else {
      if(curMovement < maxMovement) {
        moveBomb();
      } else {
        exploded = true;
        explosion = Explosion(
          gameController: gameController,
          position: position,
          radius: maxRadius,
          function: () {
            this.exploded = false;
            gameController.nextTurn();
            gameController.fired = false;
            gameController.fireBall.position = Offset(-10,-10);
          }
        );
      }
    }
  }

  void renderExplosion(Canvas canvas) {
    explosion.render(canvas);
  }

  void updateExplosion(double t) {
    explosion.update(t);
  }

  void moveBomb() {
    if (position.dx + 1  <
        gameController.playScreenSize.width) {
      position = Offset(position.dx + 1,
          gameController.mountain.points[position.dx.toInt() + 1].dy);
      curMovement++;
    } else {
      curMovement = maxMovement;
    }
  }

}