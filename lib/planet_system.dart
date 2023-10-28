import 'dart:math';

import 'package:flutter/material.dart';

class PlanetSystem extends StatefulWidget {
  @override
  _PlanetSystemState createState() => _PlanetSystemState();
}

class _PlanetSystemState extends State<PlanetSystem> {
  List<Planet> planets = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Планетная система'),
      ),
      body: Center(
        child: Stack(
          children: [
            Sun(),
            for (var planet in planets) PlanetWidget(planet),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToAddPlanetScreen();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _navigateToAddPlanetScreen() async {
    final newPlanet = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddPlanetScreen()),
    );

    if (newPlanet != null) {
      setState(() {
        planets.add(newPlanet);
      });
    }
  }
}

class Sun extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.yellow,
        shape: BoxShape.circle,
      ),
    );
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
      left: 200 + widget.planet.distance * 100.0 * cos(angle),
      top: 200 + widget.planet.distance * 100.0 * sin(angle),
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
                  color: Color(
                      0xFF000000 + int.parse(colorController.text, radix: 16)),
                  distance: double.parse(distanceController.text),
                  rotationSpeed: double.parse(speedController.text),
                );

                Navigator.pop(context, newPlanet);
              },
              child: Text('Добавить'),
            ),
          ],
        ),
      ),
    );
  }
}
