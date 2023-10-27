import 'package:flutter/material.dart';
import 'dart:math';

class AnimationOrbita extends StatefulWidget {
  const AnimationOrbita({super.key});

  @override
  State<AnimationOrbita> createState() => _AnimationOrbitaState();
}

class _AnimationOrbitaState extends State<AnimationOrbita>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: Duration(seconds: 10), upperBound: 3 + pi);

    _animationController.addListener(() {
      setState(() {});
    });
    //можем изменить размер солнца
    _animationController.forward();
    _animationController.repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: InteractiveViewer(
          maxScale: 10,
          child: CustomPaint(
            painter: Orbita(_animationController),
            child: Container(),
          ),
        ));
  }
}

class Orbita extends CustomPainter {
  final Animation<double> animation;
  Orbita(this.animation);

  @override
  void paint(Canvas canvas, Size size) async {
    final sunPaint = Paint()..color = Colors.yellow;
    final orbitPaint = Paint()
      ..color = Colors.grey.withOpacity(0.5)
      ..style = PaintingStyle.stroke;
    final zemlyaPaint = Paint()..color = Colors.blue.withOpacity(0.9);

    final zemlyaRadius = 20.0;
    const zemlyaOrbitRadius = 170.0;
    const lunaOrbitRadius = 50.0;
    const lunaRadius = 10.0;

    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), zemlyaOrbitRadius, orbitPaint);

    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 80, sunPaint);
    canvas.drawCircle(
        Offset(size.width / 2 + zemlyaOrbitRadius * cos(animation.value),
            size.height / 2 + zemlyaOrbitRadius * sin(animation.value)),
        zemlyaRadius,
        zemlyaPaint);

    final lunaX = size.width / 2 +
        zemlyaOrbitRadius * cos(animation.value) +
        lunaOrbitRadius * cos(animation.value * 5);
    final lunaY = size.height / 2 +
        zemlyaOrbitRadius * sin(animation.value) +
        lunaOrbitRadius * sin(animation.value * 5);
    final lunaPaint = Paint()..color = Colors.green.shade100;

    canvas.drawCircle(Offset(lunaX, lunaY), lunaRadius, lunaPaint);

    canvas.drawCircle(
        Offset(
          size.width / 2 + zemlyaOrbitRadius * cos(animation.value),
          size.height / 2 + zemlyaOrbitRadius * sin(animation.value),
        ),
        lunaOrbitRadius,
        orbitPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
