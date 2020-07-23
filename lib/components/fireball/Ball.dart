import 'package:flutter/cupertino.dart';

abstract class Ball {
  double time;
  Offset initialPosition;
  Offset position;
  void render(Canvas canvas);
  void update(double t);
}