import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class ClockView extends StatefulWidget {
  // dynamic size
  final double size;

  ClockView({super.key, required this.size});

  @override
  State<ClockView> createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {
  late Timer timer;
  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
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
    // const Color(0xff444974)
    var fillBrush = Paint()..color = Colors.transparent;

    // clock outline
    var outlineBrush = Paint()
      ..color = const Color(0xffeaecff)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width / 40;

    // clock center fill brush
    var centerFillBrush = Paint()..color = const Color(0xffeaecff);

    // clock second hand
    var secondHandBrush = Paint()
      ..color = Colors.orange[300]!
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width / 60;

    // clock minute hand
    var minuteHandBrush = Paint()
      ..shader =
          const RadialGradient(colors: [Color(0xff748ef6), Color(0xff77ddff)])
              .createShader(Rect.fromCircle(center: center, radius: radius))
      ..color = Colors.orange[300]!
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width / 30;

    // clock hour hand
    var hourHandBrush = Paint()
      // ..shader =
      //     const RadialGradient(colors: [Color(0xffea74ab), Color(0xffc279fb)])
      //         .createShader(Rect.fromCircle(center: center, radius: radius))
      ..color = Colors.redAccent
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width / 24;

    var dashBrush = Paint()
      ..color = Colors.grey[200]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    // canvas
    canvas.drawCircle(center, radius * 0.75, fillBrush);
    canvas.drawCircle(center, radius * 0.75, outlineBrush);

    // hour hand
    var hourHandX = centerX +
        radius *
            0.4 *
            cos((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    var hourHandY = centerX +
        radius *
            0.4 *
            sin((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    canvas.drawLine(center, Offset(hourHandX, hourHandY), hourHandBrush);

    // minute hand
    var minuteHandX =
        centerX + radius * 0.6 * cos(dateTime.minute * 6 * pi / 180);
    var minuteHandY =
        centerX + radius * 0.6 * sin(dateTime.minute * 6 * pi / 180);
    canvas.drawLine(center, Offset(minuteHandX, minuteHandY), minuteHandBrush);

    // second hand
    var secondHandX =
        centerX + radius * 0.6 * cos(dateTime.second * 6 * pi / 180);
    var secondHandY =
        centerX + radius * 0.6 * sin(dateTime.second * 6 * pi / 180);
    canvas.drawLine(center, Offset(secondHandX, secondHandY), secondHandBrush);

    // center circle
    canvas.drawCircle(center, radius * 0.10, centerFillBrush);

    // dashes around the circles
    var outerRadius = radius;
    var innerRadius = radius * 0.9;

    for (var i = 0; i < 360; i += 12) {
      var x1 = centerX + outerRadius * cos(i * pi / 180);
      var y1 = centerY + outerRadius * sin(i * pi / 180);

      var x2 = centerX + innerRadius * cos(i * pi / 180);
      var y2 = centerY + innerRadius * sin(i * pi / 180);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
