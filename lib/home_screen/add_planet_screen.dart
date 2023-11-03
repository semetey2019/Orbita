// import 'package:flutter/material.dart';
// import 'package:solar_sistem/exzample.dart';

// class AddPlanetScreen extends StatelessWidget {
//   final TextEditingController radiusController = TextEditingController();
//   final TextEditingController colorController = TextEditingController();
//   final TextEditingController distanceController = TextEditingController();
//   final TextEditingController speedController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Добавить планету'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: radiusController,
//               decoration: const InputDecoration(labelText: 'Радиус'),
//               keyboardType: TextInputType.number,
//             ),
//             TextField(
//               controller: colorController,
//               decoration: const InputDecoration(
//                   labelText: 'Цвет (например, Colors.blue)'),
//             ),
//             TextField(
//               controller: distanceController,
//               decoration: const InputDecoration(labelText: 'Удаленность'),
//               keyboardType: TextInputType.number,
//             ),
//             TextField(
//               controller: speedController,
//               decoration: const InputDecoration(labelText: 'Скорость вращения'),
//               keyboardType: TextInputType.number,
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 final newPlanet = Planet(
//                   radius: double.parse(radiusController.text),
//                   color: Color(int.parse(colorController.text)),
//                   distance: double.parse(distanceController.text),
//                   rotationSpeed: double.parse(speedController.text),
//                 );

//                 Navigator.pop(context, newPlanet);
//               },
//               child: const Text("planets.add"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:solar_sistem/exzample.dart';

class AddPlanetScreenFirst extends StatefulWidget {
  const AddPlanetScreenFirst({Key? key}) : super(key: key);

  @override
  _AddPlanetScreenFirstState createState() => _AddPlanetScreenFirstState();
}

class _AddPlanetScreenFirstState extends State<AddPlanetScreenFirst> {
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
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
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
                      Future.delayed(Duration.zero, () {
                        Navigator.pop(context, planet);
                      });
                    }
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
