import 'package:flutter/material.dart';
import 'package:solar_sistem/chat.dart';
import 'package:solar_sistem/exzample.dart';
import 'package:solar_sistem/home_screen/home_screen.dart';
import 'package:solar_sistem/planety/sun_system.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(useMaterial3: true),
      themeMode: ThemeMode.system,
      home: SolarSystemSun(),
    );
  }
}
