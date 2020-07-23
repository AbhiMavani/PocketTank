import 'package:tankgame/game_controller.dart';

class TankPower {
  final GameController gameController;
  double energy;
  int climbingCapacity;
  double shieldPower;
  double engine;
  TankPower({this.gameController}) {
    energy = shieldPower = engine = 1;
    climbingCapacity = 1;
  }
  void upgradeEnergy() {
    engine += 0.1;
  }

  void upgradeClimbingCapacity() {
    climbingCapacity++;
  }

  void upgradeShieldPower() {
    shieldPower += 0.1;
  }
  void upgradeEngine() {
    shieldPower += 0.1;
  }


}