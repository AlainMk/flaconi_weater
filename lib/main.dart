import 'package:flaconi_weather/shared/di.dart';
import 'package:flaconi_weather/theme/theme.dart';
import 'package:flaconi_weather/weather/ui/weather_screen.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DependencyInjector.inject();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flaconi Weather',
      theme: FlaconiTheme.light(),
      debugShowCheckedModeBanner: false,
      home: const WeatherScreen(),
    );
  }
}
