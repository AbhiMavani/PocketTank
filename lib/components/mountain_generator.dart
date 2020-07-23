import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tankgame/game_controller.dart';

class MountainGenerator {
  static List<Offset> generatePoints(Size dimension) {
    Random random = Random();
    List<Equation> equations = List<Equation>();
    int numberOfEquation = random.nextInt(8) + 3;
    for (int i = 0; i < numberOfEquation; i++) {
      double amplitude = random.nextInt(dimension.height ~/ 8).toDouble();
      double shift = random.nextInt(10) * random.nextDouble();
      double divider = random.nextDouble() * 20;
      equations.add(Equation(amplitude, shift, dimension.height / 2,
          dimension.width, divider)); //random.nextDouble()*100)
    }
    List<Offset> points = List(dimension.width.toInt());
    double height;
    for (int i = 0; i < points.length; i++) {
      height = dimension.height / 2;
      if (height < 0) height = 0;
      equations.forEach((Equation equation) {
        height += equation.getValue(i);
      });
      points[i] = Offset(i.toDouble(), height);
    }

    return points;
  }
}

class Equation {
  double amplitude;
  double shift;
  double height;
  double width;
  double divider;
  Equation(this.amplitude, this.shift, this.height, this.width, this.divider);
  double getValue(int time) {
    double multiplier = width / divider;
    return amplitude * sin(time / multiplier + shift);
//  return 0;
  }
}

class Line {
  Offset start;
  Offset end;
  bool flag;
  Line({this.start, this.end}) {
    flag = true;
  }
  void shift() {
    start += Offset(0, 1);
    end += Offset(0, 1);
  }
  bool isSafe(Offset offset) {
    return end.dy >= offset.dy;
  }

}

class Mountain {
  final GameController gameController;
  int length;
  List<Offset> points;
  List<Line> lines;
  Mountain(this.gameController) {
    points = MountainGenerator.generatePoints(gameController.playScreenSize);
    length = points.length;
    lines = List<Line>();

  }


  void render(Canvas canvas) {
    Rect rect = Rect.fromLTWH(0, 0, gameController.playScreenSize.width,
        gameController.playScreenSize.height);
    Paint linePaint = Paint();

    Gradient gradient = LinearGradient(
        begin: Alignment.bottomRight,
        end: Alignment.bottomLeft,
        colors: [Color(0xff3a9452), Colors.green[400]]);
    linePaint.shader = gradient.createShader(rect);
    Paint paint = Paint()..color = Colors.white;



    for (int i = 0; i < points.length; i++) {
      canvas.drawLine(
          points[i],
          Offset(points[i].dx, gameController.playScreenSize.height),
          linePaint);
    }
    canvas.drawPoints(PointMode.polygon, points, paint);

    if(lines != null) {
      lines.forEach((Line line){
        canvas.drawLine(line.start, line.end, linePaint);
      });
    }

  }

  void update(double t) {
    if(lines != null) {
      lines.forEach((Line line){
        line.start += Offset(0, 3);
        line.end += Offset(0, 3);
        if(line.end.dy >= points[line.start.dx.toInt()].dy) {
          line.flag = false;
          points[line.start.dx.toInt()] = line.start;
        }

      });
      lines.removeWhere((Line line) => !line.flag);

    }
  }

  void cutMountain(Offset position, double radius) {
    if(lines == null) {
      lines = List<Line>();
    }
    radius /= 2;

    for (int i = -radius.toInt(); i < radius-1 && position.dx + i < points.length && position.dx + i >= 0; i++) {
      double line = sqrt((radius * radius - i * i).abs());
      double blastMaxHeight = position.dy + line;
      double blastMinHeight = position.dy - line;
      if (points[position.dx.toInt() + i].dy >= blastMinHeight &&
          points[position.dx.toInt() + i].dy <= blastMaxHeight) {
        points[position.dx.toInt() + i] =
            Offset(points[position.dx.toInt() + i].dx, position.dy + line);
      } else if (points[position.dx.toInt() + i].dy < blastMinHeight) {
        Offset temp = Offset(
            points[position.dx.toInt() + i].dx,
            position.dy + line);
        lines.add(Line(start: points[position.dx.toInt() + i], end: temp - Offset(0, 2 * line)));
        points[position.dx.toInt() + i] = temp;
      }
    }
  }

}
