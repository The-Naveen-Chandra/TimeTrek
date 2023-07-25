import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class ClockView extends StatefulWidget {
  const ClockView({super.key});

  @override
  State<ClockView> createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {
  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 300,
      child: Transform.rotate(
        angle: -pi / 2,
        child: CustomPaint(
          painter: ClockPainter(),
        ),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  // current time
  var dateTime = DateTime.now();

  // 60 second - 360, 1 second - 6 degree
  // 60 minute - 360, 1 minute - 6 degree
  // 12 hours - 360 , 1 hour - 360 degree, 1 min - 0.5 degree

  @override
  void paint(Canvas canvas, Size size) {
    // X and Y axis
    var centerX = size.width / 2;
    var centerY = size.height / 2;

    // center
    var center = Offset(centerX, centerY);

    // radius
    var radius = min(centerX, centerY);

    // clock background
    var fillBrush = Paint()..color = const Color(0xff444974);

    // clock outline
    var outlineBrush = Paint()
      ..color = const Color(0xffeaecff)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16;

    // clock center fill brush
    var centerFillBrush = Paint()..color = const Color(0xffeaecff);

    // clock second hand
    var secondHandBrush = Paint()
      ..color = Colors.orange[300]!
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 8;

    // clock minute hand
    var minuteHandBrush = Paint()
      ..shader =
          const RadialGradient(colors: [Color(0xff748ef6), Color(0xff77ddff)])
              .createShader(Rect.fromCircle(center: center, radius: radius))
      ..color = Colors.orange[300]!
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 16;

    // clock hour hand
    var hourHandBrush = Paint()
      ..shader =
          const RadialGradient(colors: [Color(0xffea74ab), Color(0xffc279fb)])
              .createShader(Rect.fromCircle(center: center, radius: radius))
      ..color = Colors.orange[300]!
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 16;

    // canvas
    canvas.drawCircle(center, radius - 40, fillBrush);
    canvas.drawCircle(center, radius - 40, outlineBrush);

    // hour hand
    var hourHandX = centerX +
        60 * cos((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    var hourHandY = centerX +
        60 * sin((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    canvas.drawLine(center, Offset(hourHandX, hourHandY), hourHandBrush);

    // minute hand
    var minuteHandX = centerX + 80 * cos(dateTime.minute * 6 * pi / 180);
    var minuteHandY = centerX + 80 * sin(dateTime.minute * 6 * pi / 180);
    canvas.drawLine(center, Offset(minuteHandX, minuteHandY), minuteHandBrush);

    // second hand
    var secondHandX = centerX + 80 * cos(dateTime.second * 6 * pi / 180);
    var secondHandY = centerX + 80 * sin(dateTime.second * 6 * pi / 180);
    canvas.drawLine(center, Offset(secondHandX, secondHandY), secondHandBrush);

    // center circle
    canvas.drawCircle(center, 16, centerFillBrush);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
