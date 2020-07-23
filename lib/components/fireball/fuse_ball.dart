import 'dart:ui';

import 'package:tankgame/components/fireball/fire_ball.dart';

import '../explosion.dart';

class FuseBall extends FireBall {
  List<Explosion> secondExplosions;
  FuseBall({gameController, initialPosition, fireDetails}) : super(gameController: gameController,initialPosition: initialPosition, fireDetails: fireDetails);
  void setExplode() {
    print('Set explode was called');
    exploded = true;
    explosion = Explosion(
      gameController: gameController, position: position, radius: gameController.tileSize * 2, function: () {}, );
    secondExplosions = List<Explosion>();
    secondExplosions.add(Explosion(
        gameController: gameController,
        position: position - Offset(explosion.radius / 2, explosion.radius / 2),
        damageFactor: 0.5 * explosion.damageFactor,
        radius: explosion.radius,
        function: () {}));
    secondExplosions.add(Explosion(
        gameController: gameController,
        position: position + Offset(explosion.radius / 2, explosion.radius / 2),
        damageFactor: 0.5 * explosion.damageFactor,
        radius: explosion.radius,
        function: () {}));
    secondExplosions.add(Explosion(
        gameController: gameController,
        position: position + Offset(explosion.radius / 2, -explosion.radius / 2),
        damageFactor: 0.5 * explosion.damageFactor,
        radius: explosion.radius,
        function: () {}));
    secondExplosions.add(Explosion(
        gameController: gameController,
        position: position + Offset(-explosion.radius / 2, explosion.radius / 2),
        damageFactor: 0.5 * explosion.damageFactor,
        radius: explosion.radius,
        function: () {
          this.exploded = false;
          gameController.nextTurn();
          gameController.fired = false;
          gameController.fireBall.position = Offset(-10, -10);
        }));
  }

  void renderExplosion(Canvas canvas) {
    explosion.render(canvas);
    if (explosion.flag && secondExplosions != null) {
      secondExplosions.forEach((Explosion explosion) {
        explosion.render(canvas);
      });
    }
  }

  void updateExplosion(double t) {
    explosion.update(t);
    if (explosion.flag && secondExplosions != null) {
      secondExplosions.forEach((Explosion explosion) {
        explosion.update(t);
      });
    }
  }
}