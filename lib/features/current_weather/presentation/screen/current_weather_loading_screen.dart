import 'package:flutter/material.dart';

class CurrentWeatherLoadingScreen extends StatelessWidget {
  const CurrentWeatherLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
