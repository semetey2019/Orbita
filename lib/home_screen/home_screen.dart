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
  final List<Planet> planets = [];
  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(seconds: 10), upperBound: 3 + pi);

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
      backgroundColor: Colors.black12,
      body: InteractiveViewer(
        maxScale: 5,
        child: CustomPaint(
          painter: Orbita(_animationController),
          child: Container(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Planet? planet = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddPlanetScreen()),
          );
          if (planet != null) {
            _addPlanet(planet);
          }
        },
        child: Icon(Icons.add),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     _navigateToAddPlanetScreen();
      //   },
      //   child: Icon(Icons.add),
      // ),
    );
  }

  void _addPlanet(Planet planet) {
    setState(() {
      planets.add(planet);
    });
  }
  // void _navigateToAddPlanetScreen() async {
  //   final newPlanet = await Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => AddPlanetScreen()),
  //   );

  //   if (newPlanet != null) {
  //     setState(() {
  //       planets.add(newPlanet);
  //     });
  //   }
  // }
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

class Planet {
  final double radius;
  final Color color;
  final double distance;
  final double rotationSpeed;

  Planet(
      {required this.radius,
      required this.color,
      required this.distance,
      required this.rotationSpeed});
}

class PlanetWidget extends StatefulWidget {
  final Planet planet;

  PlanetWidget(this.planet);

  @override
  _PlanetWidgetState createState() => _PlanetWidgetState();
}

class _PlanetWidgetState extends State<PlanetWidget> {
  double angle = 0.0;

  @override
  void initState() {
    super.initState();
    _startRotation();
  }

  void _startRotation() {
    Future.delayed(Duration(milliseconds: 16), () {
      setState(() {
        angle += widget.planet.rotationSpeed;
        _startRotation();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 100 + widget.planet.distance * 50.0 * cos(angle),
      top: 100 + widget.planet.distance * 50.0 * sin(angle),
      child: Container(
        width: widget.planet.radius * 2,
        height: widget.planet.radius * 2,
        decoration: BoxDecoration(
          color: widget.planet.color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class AddPlanetScreen extends StatelessWidget {
  final TextEditingController radiusController = TextEditingController();
  final TextEditingController colorController = TextEditingController();
  final TextEditingController distanceController = TextEditingController();
  final TextEditingController speedController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Добавить планету'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: radiusController,
              decoration: InputDecoration(labelText: 'Радиус'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: colorController,
              decoration:
                  InputDecoration(labelText: 'Цвет (например, Colors.blue)'),
            ),
            TextField(
              controller: distanceController,
              decoration: InputDecoration(labelText: 'Удаленность'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: speedController,
              decoration: InputDecoration(labelText: 'Скорость вращения'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: () {
                final newPlanet = Planet(
                  radius: double.parse(radiusController.text),
                  color: Color(int.parse(colorController.text)),
                  // color: Color(
                  //     int.parse("0xFF" + colorController.text, radix: 16)),
                  // color: Color(
                  //     0xFF000000 + int.parse(colorController.text, radix: 16)),
                  distance: double.parse(distanceController.text),
                  rotationSpeed: double.parse(speedController.text),
                );

                Navigator.pop(context, newPlanet);
              },
              child: const Text("planets.add"),
            ),
          ],
        ),
      ),
    );
  }
}
