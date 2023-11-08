import 'package:flutter/material.dart';

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

class SolarSystemSun extends StatefulWidget {
  const SolarSystemSun({Key? key}) : super(key: key);

  @override
  _SolarSystemSunState createState() => _SolarSystemSunState();
}

class _SolarSystemSunState extends State<SolarSystemSun>
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
      appBar: AppBar(
        title: const Text('Solar System'),
      ),
      body: Center(
        child: Stack(
          children: [
            Container(
              width: 300,
              height: 150,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.yellow,
              ),
            ),
            for (int i = 0; i < _planets.length; i++)
              Positioned(
                left: 50 + _planets[i].distance * _controller.value,
                child: RotationTransition(
                  turns: _controller,
                  child: Container(
                    width: _planets[i].radius * 2,
                    height: _planets[i].radius * 2,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _planets[i].color,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Planet? planet = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddPlanetScreen()),
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

class AddPlanetScreen extends StatefulWidget {
  const AddPlanetScreen({Key? key}) : super(key: key);

  @override
  _AddPlanetScreenState createState() => _AddPlanetScreenState();
}

class _AddPlanetScreenState extends State<AddPlanetScreen> {
  final _formKey = GlobalKey<FormState>();
  final _radiusController = TextEditingController();
  final _colorController = TextEditingController();
  final _distanceController = TextEditingController();
  final _rotationSpeedController = TextEditingController();

  @override
  void dispose() {
    _radiusController.dispose();
    _colorController.dispose();
    _distanceController.dispose();
    _rotationSpeedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Planet'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _radiusController,
                decoration: const InputDecoration(
                  labelText: 'Radius',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a radius';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _colorController,
                decoration: const InputDecoration(
                  labelText: 'Color',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a color';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _distanceController,
                decoration: const InputDecoration(
                  labelText: 'Distance',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a distance';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _rotationSpeedController,
                decoration: const InputDecoration(
                  labelText: 'Rotation Speed',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a rotation speed';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Planet planet = Planet(
                      radius: double.parse(_radiusController.text),
                      color: Color(int.parse(_colorController.text)),
                      distance: double.parse(_distanceController.text),
                      rotationSpeed:
                          double.parse(_rotationSpeedController.text),
                    );
                    Navigator.pop(context, planet);
                  }
                },
                child: const Text('Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
