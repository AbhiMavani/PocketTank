import 'dart:math';

class Wind {
  double windPower = 0;
  final int minPower = -30;
  final int maxPower = 30;
  final int maxChange = 20;
  final double gravity = 8;
  Random random;
  Wind() {
    random = Random();
    windPower = random.nextDouble() * maxPower / 2;
    windPower *= (random.nextInt(100)%2 == 0 ? 1 : -1);
  }
  void updateWind(){
    double temp = random.nextDouble() * maxChange;
    temp = (random.nextInt(100)%2 == 0 ? temp : -temp);
    temp += windPower;
    if(!windInRange(temp))
      updateWind();
    else
      windPower = temp;

  }
  bool windInRange(double windPower) {
    return windPower < maxPower && windPower > minPower;
  }
}