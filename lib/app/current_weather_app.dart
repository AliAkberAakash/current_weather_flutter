import 'package:current_weather/features/weather_forecast/presentation/weather_forecast_screen.dart';
import 'package:current_weather_design_system/styles/theme/theme.dart';
import 'package:flutter/material.dart';

class CurrentWeatherApp extends StatelessWidget {
  const CurrentWeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Leafy',
      theme: theme.light(),
      darkTheme: theme.dark(),
      debugShowCheckedModeBanner: false,
      home: const WeatherForecastScreen(),
    );
  }
}
