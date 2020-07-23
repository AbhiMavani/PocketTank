import 'dart:math';
import 'dart:ui';

import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tankgame/game_controller.dart';

class Cloud {
  final GameController gameController;
  Sprite sprite;
  Rect cloudRect;
  Offset position;
  Offset curPosition;
  double time;
  bool isDead = false;
  double width;
  double height;
  Position imageSize;

  Cloud(this.gameController) {
    width = gameController.tileSize * 2;
    height = gameController.tileSize ;
    imageSize = Position(width, height);
    int a = Random().nextInt(3);
    String image = 'cloud$a.png';
    sprite = Sprite(image);
    if (gameController.wind.windPower <= 0)
      cloudRect = Rect.fromLTWH(gameController.screenSize.width, 20, width, height);
    else
      cloudRect = Rect.fromLTWH(-10, 20, width, height);
    curPosition = Offset(cloudRect.left, cloudRect.top);
    position = curPosition;
    time = 0.0;
  }

  void render(Canvas c) {
    sprite.renderPosition(c, Position(position.dx, position.dy), size: imageSize);
    cloudRect = Rect.fromLTWH(position.dx, position.dy, width, height);
  }

  void update(double t) {
    time += 0.1;
    double dx = curPosition.dx + time * gameController.wind.windPower;
    position = Offset(dx, curPosition.dy);
    if ((gameController.wind.windPower <= 0 && position.dx + cloudRect.width <= 0.0) ||
        (gameController.wind.windPower > 0 &&
            position.dx > gameController.screenSize.width)) {
      isDead = true;
    }
  }
}
