import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../game_controller.dart';


class WindDisplay {

  final GameController gameController;
  TextPainter painter;
  Offset position;


  WindDisplay(this.gameController) {
    painter = TextPainter(
        textAlign: TextAlign.left, textDirection: TextDirection.ltr);
    position = Offset.zero;
  }

  void render(Canvas canvas) {
    painter.paint(canvas, position);
    double windPower = gameController.wind.windPower / gameController.wind.maxPower * painter.width;
    Paint paint = Paint()..color = Colors.white;
    double startingPoint = (windPower > 0 ? 0 : painter.width);
    Offset midPoint = Offset(painter.width * 1 / 4 + startingPoint + windPower, painter.height * 2.3 + 2);

    canvas.drawLine(Offset(painter.width * 1 / 4 + startingPoint, painter.height * 2 + 2), midPoint, paint);
    canvas.drawLine(Offset(painter.width * 1 / 4 + startingPoint, painter.height * 2.6 + 2), midPoint, paint);



  }

  void update(double t) {

      painter.text = TextSpan(
          text: 'Wind: ' + gameController.wind.windPower.toInt().toString(),
          style: TextStyle(color: Colors.white, fontSize: 10.0));
      painter.layout();
      position = Offset(painter.width / 4, painter.height);

  }
}
