import 'dart:math';

import 'package:flame/flame.dart';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tankgame/Shield/SuperShield.dart';
import 'package:tankgame/Shield/normalShield.dart';
import 'package:tankgame/Shield/shield.dart';
import 'package:tankgame/Shield/strongShield.dart';
import 'package:tankgame/Shield/weakShield.dart';
import 'package:tankgame/components/ball_factory.dart';
import 'package:tankgame/components/tank_power.dart';
import 'package:tankgame/game_controller.dart';

import 'explosion.dart';
import 'fire_details.dart';
import 'fireball/Ball.dart';

class Tank {
  final GameController gameController;
  bool alive = true;
  double health = 100;
  int fuel = 250;
  Offset position;
  Offset canonPosition;
  String color;
  double tileSize;
  Position imageSize;
  Sprite sprite;
  bool buttonPressed = false;
  Ball fireBall;
  bool exploded = false;
  Path tankPath;
  ShieldDetails shieldDetails;
  var image;
  FireDetails fireDetails;
  double temp;
  TankPower tankPower;
  Explosion explosion;
  String playerName;
  String selectedWeapon = 'FireBall';
  double score = 0.0;
  Tank({this.gameController, this.color, this.playerName}) {
    fireDetails = FireDetails(
      power: 50.0,
      angle: degreeToRadian(45),
    );
    Random random = Random();
    int pos = random.nextInt(gameController.mountain.points.length - 10);
    position = gameController.mountain.points[pos];
    initiate();
    tileSize = gameController.playScreenSize.width / 25;
    imageSize = Position(tileSize, tileSize * 0.6);
  }
  void initiate() async {
    image = await Flame.images.load('$color.png');
    tankPower = TankPower(gameController: gameController);
    this.sprite = Sprite.fromImage(image);
    tankPath = Path();
  }

  void render(Canvas canvas) {

    if(alive) {
      temp = gameController.playScreenSize.height;
      for (int i = position.dx.toInt() - imageSize.x ~/ 2;
      i < position.dx.toInt() + imageSize.x / 2;
      i++) {
        temp = min(temp, gameController.mountain.points[i].dy);
      }
      sprite.renderPosition(
          canvas, Position(position.dx - imageSize.x / 2, temp - imageSize.y),
          size: imageSize);
      Paint paint = Paint()..color = Colors.white;
      canonPosition = Offset(
          position.dx + tileSize * 0.5 * cos(fireDetails.angle),
          temp - imageSize.y - tileSize * 0.5 * sin(fireDetails.angle));
      canvas.drawLine(Offset(position.dx, temp - imageSize.y), canonPosition,
          paint); // tank-head

      if (shieldDetails != null) {
        Offset shieldPos = Offset(position.dx, temp - imageSize.y / 1.5);
//      shieldDetails.shieldPosition = shieldPos;
        double shieldRadius = gameController.tileSize;
        paint = new Paint();
        paint..isAntiAlias = true;
        paint
          ..color = (shieldDetails.color).withAlpha(
              ((shieldDetails.curHealth / shieldDetails.maxHealth) * 255)
                  .toInt());
        paint..style = PaintingStyle.stroke;
        paint..strokeWidth = ((gameController.tileSize) / 2.5);

        paint
          ..shader = RadialGradient(colors: [
            Colors.white,
            shieldDetails.color.withOpacity(0.25),
          ], tileMode: TileMode.mirror)
              .createShader(Rect.fromCircle(
            center: shieldPos,
            radius: gameController.tileSize * 0.7,
          ));
        canvas.drawCircle(shieldPos, shieldRadius, paint);
      }

      if (shieldDetails == null) {
        Offset base = Offset(position.dx - imageSize.x / 2, temp - imageSize.y);
        List<Offset> offsets = List<Offset>();
        offsets.add(Offset(base.dx + imageSize.x * 0.3, base.dy));
        offsets.add(Offset(base.dx + imageSize.x * 0.7, base.dy));
        offsets.add(Offset(base.dx + imageSize.x, base.dy + imageSize.y * 0.55));
        offsets.add(Offset(base.dx + imageSize.x * 0.9, base.dy + imageSize.y));
        offsets.add(Offset(base.dx + imageSize.x * 0.1, base.dy + imageSize.y));
        offsets.add(Offset(base.dx, base.dy + imageSize.y * 0.55));
        tankPath = Path();
        tankPath.addPolygon(offsets, true);
      } else {
        tankPath = Path();
        Offset shieldPos = Offset(position.dx, temp - imageSize.y / 1.5);
        double shieldRadius =
            gameController.tileSize + (gameController.tileSize) / 5;
        Rect rect = Rect.fromCircle(center: shieldPos, radius: shieldRadius);
        tankPath.addOval(rect);
      }
    } else if(explosion != null){
//      explosion.render(canvas);
    }
  }

  void update(double t) {
    if(alive) {
      if (position.dy != gameController.mountain.points[position.dx.toInt()].dy)
        position = Offset(
            position.dx, gameController.mountain.points[position.dx.toInt()].dy);
    } else if(explosion != null){
//      explosion.update(t);
    }

  }

  void moveLeft(Function function) {
    if (position.dx - 1 - imageSize.x / 2 > 0) {
      position = Offset(position.dx - 1,
          gameController.mountain.points[position.dx.toInt() - 1].dy);
      function();
    }
  }

  void moveRight(Function function) {
    if (position.dx + 1 + imageSize.x / 2 <
        gameController.playScreenSize.width) {
      position = Offset(position.dx + 1,
          gameController.mountain.points[position.dx.toInt() + 1].dy);
      function();
    }
  }

  void fire() {
    if (!gameController.fired) {
      gameController.fired = true;
//      fireDetails.firePosition = canonPosition;
      gameController.fireBall.initialPosition = canonPosition;
      gameController.fireBall = BallFactory.getBall(
          gameController: gameController,
          initialPosition: canonPosition,
          fireDetails: fireDetails,
          name: selectedWeapon
      );
    }
  }

  static double degreeToRadian(double degree) {
    return degree * 3.14 / 180;
  }

  void setAngle(double degree) {
    fireDetails.angle = degreeToRadian(degree);
  }

  void increaseAngle() {
    fireDetails.angle =
        degreeToRadian((1 + fireDetails.angle * 180 / 3.14) % 360);
    fireDetails.angle += 3.14 / 180;
  }

  void decreaseAngle() {
    double temp = fireDetails.angle * 180 / 3.14 - 1;
    fireDetails.angle = degreeToRadian(temp > 0 ? temp : 360);
  }

  void teleportPosition(Offset offset) {
    position = offset;
//    function();
  }

  void setShield(int level) {
    if (level == 1) {
      shieldDetails = new WeakShield();
    } else if (level == 2) {
      shieldDetails = new NormalShield();
    } else if (level == 3) {
      shieldDetails = new StrongShield();
    } else if (level == 4) {
      shieldDetails = new SuperShield();
    }
  }

  bool contain(Offset pos) {
    if (gameController.tank == this) {
      return false;
    } else
      return tankPath.contains(pos);
  }

  void damageDealt(double damage) {
    if (shieldDetails != null) {
      shieldDetails.curHealth -= damage / tankPower.shieldPower;
      if (shieldDetails.curHealth <= 0) {
        damage = shieldDetails.curHealth.abs();
        shieldDetails = null;
      } else {
        damage = 0;
      }
    }
    health -= damage;
    if (health <= 0) {
      alive = false;
      gameController.alivePlayer--;
    }
  }
}
