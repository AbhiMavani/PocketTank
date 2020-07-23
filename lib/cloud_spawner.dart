import 'dart:math';

import 'package:tankgame/components/cloud.dart';
import 'package:tankgame/game_controller.dart';

class CloudSpawner {
  final GameController gameController;
  final int maxSpawnInterval = 3000;
  final int minSpawnInterval = Random().nextInt(3000);
  final int intervalChange = 15;
  final int maxclouds = 3;
  int currentInterval;
  int nextSpawn;

  CloudSpawner(this.gameController) {
    initialize();
  }

  void initialize() {
    allCloudDestroyed();
    currentInterval = maxSpawnInterval;
    nextSpawn = DateTime.now().millisecondsSinceEpoch + currentInterval;
  }

  void allCloudDestroyed() {
    gameController.clouds.forEach((Cloud cloud) => cloud.isDead = true);
  }

  void update(double t) {
    int now = DateTime.now().millisecondsSinceEpoch;
    if (gameController.clouds.length < maxclouds && now >= nextSpawn) {
      gameController.clouds.add(Cloud(this.gameController));
      if (currentInterval > minSpawnInterval) {
        currentInterval -= intervalChange;
        currentInterval -= (currentInterval * 0.1).toInt();
      }
      nextSpawn = now + currentInterval;
    }
  }


}