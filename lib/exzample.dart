import 'package:flutter/material.dart';
import 'package:solar_sistem/home_screen/add_planet_screen.dart';
import 'package:solar_sistem/home_screen/home_screen.dart';

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

class SolarSystem extends StatefulWidget {
  const SolarSystem({Key? key}) : super(key: key);

  @override
  _SolarSystemState createState() => _SolarSystemState();
}

class _SolarSystemState extends State<SolarSystem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<Planet> _planets = [];

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 10))
          ..repeat();
    _planets.add(
        Planet(radius: 20, color: Colors.red, distance: 50, rotationSpeed: 1));
    _planets.add(Planet(
        radius: 30, color: Colors.green, distance: 100, rotationSpeed: 0.5));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addPlanet(Planet planet) {
    setState(() {
      _planets.add(planet);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Solar System'),
      ),
      body: InteractiveViewer(
        maxScale: 10,
        child: CustomPaint(
          painter: Orbita(_controller),
          child: Center(
            child: Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.yellow,
              ),
            ),
          ),
          // for (int i = 0; i < _planets.length; i++)
          //   Positioned(
          //     right: 20,
          //     left: 60 + _planets[i].distance * _controller.value,
          //     child: RotationTransition(
          //       turns: _controller,
          //       child: Container(
          //         width: _planets[i].radius * 2,
          //         height: _planets[i].radius * 2,
          //         decoration: BoxDecoration(
          //           shape: BoxShape.circle,
          //           color: _planets[i].color,
          //         ),
          //       ),
          //     ),
          //   ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Planet? planet = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddPlanetScreenFirst()),
          );
          if (planet != null) {
            _addPlanet(planet);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
