import 'dart:ui';

import 'package:tankgame/components/fire_details.dart';

import '../Tank.dart';
import '../explosion.dart';
import 'fire_ball.dart';

class VolcanoBomb extends FireBall {
  bool flag = false;
  List<CustomFireBall> fireBalls;
  VolcanoBomb({gameController, initialPosition, fireDetails}) : super(gameController: gameController,initialPosition: initialPosition, fireDetails: fireDetails);
  int count = 0;
  void increaseCount() {
    count++;
    if(count == 5){
      this.exploded = false;
      gameController.nextTurn();
      gameController.fired = false;
    }
  }
  @override
  void setExplode() {
    exploded = true;
    explosion = Explosion(gameController: gameController,  position: position, radius: gameController.tileSize / 2,function: (){
      gameController.fireBall.position = Offset(-10, -10);
    });
    fireBalls = List<CustomFireBall>();
    double power = 20.0;
    double angle = 75;
    double delta = 15.0;
    double prev = 0.0;
    for(int i = 0; i < 5; i++) {
      fireBalls.add(CustomFireBall(gameController: gameController, initialPosition: position, fireDetails: FireDetails(angle: Tank.degreeToRadian((angle + delta * i) % 180), power: power), function: increaseCount));
    }

  }

  void renderExplosion(Canvas canvas) {
    if(exploded)
      explosion.render(canvas);
    if(fireBalls != null  && !flag) {
      fireBalls.forEach((CustomFireBall fireBall){
//        print('fireballs[${fireBalls.indexOf(fireBall)}].render');

        fireBall.render(canvas);
      });
    }
  }

  void updateExplosion(double t) {
    if(exploded)
      explosion.update(t);
    if(fireBalls != null ){
//      print('fireballs.update');
      fireBalls.forEach((CustomFireBall fireBall){
        fireBall.update(t);
      });
    }
  }



}

class CustomFireBall extends FireBall{
  Function function;
  CustomFireBall({gameController, initialPosition, fireDetails, this.function}) : super(gameController: gameController,initialPosition: initialPosition, fireDetails: fireDetails) {
    if(function == null) {
      function = (){
        exploded = false;
        position = Offset(-10, -10);
      };
    }
  }
  void setExplode() {
    exploded = true;
    explosion = Explosion(gameController: gameController,  position: position, function: function ,radius: gameController.tileSize / 2.5);
  }
}