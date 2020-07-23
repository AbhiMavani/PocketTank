import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tankgame/components/game_status.dart';
import 'package:tankgame/game_controller.dart';
class AnimationCircle extends StatefulWidget {

  final GameController gameController;
  final updateState;

  AnimationCircle({this.gameController,this.updateState});
  @override
  _AnimationCircleState createState() => _AnimationCircleState();
}

class _AnimationCircleState extends State<AnimationCircle> with SingleTickerProviderStateMixin{

  AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds:1),

      vsync: this,
    )..repeat(reverse: true);
    startTime();
  }

  startTime() async {
    var duration = new Duration(seconds: 3);
    return new Timer(duration, route);
  }

  route() {

    widget.gameController.gameStatus = Status.homeScreen;
    widget.updateState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey,
      
      child:new  Stack(
        children: <Widget>[
          Center(
            child: AspectRatio(
              aspectRatio: 1.0,
              child: CustomPaint(
                painter: _BreathePainter(
                    CurvedAnimation(parent: _controller, curve: Curves.fastLinearToSlowEaseIn)),
                size: Size.infinite,
              ),
            ),
          ),

          Center(child: Text(
              "TANKS",
            style: TextStyle(
              fontSize: widget.gameController.tileSize*3.5,
              color: Colors.blueGrey,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic
            ),
          ))
        ],
      ),
    );
  }
}


class _BreathePainter extends CustomPainter {
  _BreathePainter(
      this.animation, {
        this.count = 6,
        Color color = Colors.red,
      })  : circlePaint = Paint()
    ..color = color
    ..blendMode = BlendMode.screen,
        super(repaint: animation);

  final Animation<double> animation;
  final int count;
  final Paint circlePaint;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = (size.shortestSide * 0.25) * animation.value;
    for (int index = 0; index < count; index++) {
      final indexAngle = (index * math.pi / count * 2);
      final angle = indexAngle + (math.pi * 1.5 * animation.value);
      final offset = Offset(math.sin(angle), math.cos(angle)) * radius * 0.985;
      canvas.drawCircle(center + offset * animation.value, radius, circlePaint);
    }
  }

  @override
  bool shouldRepaint(_BreathePainter oldDelegate) =>
      animation != oldDelegate.animation;
}



