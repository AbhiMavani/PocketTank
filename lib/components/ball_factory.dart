import 'package:flutter/cupertino.dart';
import 'package:tankgame/components/fire_details.dart';
import 'package:tankgame/components/fireball/Ball.dart';
import 'package:tankgame/components/fireball/fire_ball.dart';
import 'package:tankgame/game_controller.dart';

import 'fireball/fuse_ball.dart';
import 'fireball/large_ball_v1.dart';
import 'fireball/volcano_bomb.dart';

class BallFactory {
  static Ball getBall({String name, GameController gameController, FireDetails fireDetails, Offset initialPosition}) {
    Ball fireBall;
    switch(name) {
      case 'FireBall':
        fireBall = FireBall(gameController: gameController, fireDetails: fireDetails, initialPosition: initialPosition);
        break;
      case 'FuseBall':
        fireBall = FuseBall(gameController: gameController, fireDetails: fireDetails, initialPosition: initialPosition);
        break;
      case 'LargeBall':
        fireBall = LargeBall(gameController: gameController, fireDetails: fireDetails, initialPosition: initialPosition);
        break;
      case 'VolcanoBomb':
        fireBall = VolcanoBomb(gameController: gameController, fireDetails: fireDetails, initialPosition: initialPosition);
        break;
    }

    return fireBall;
  }
}