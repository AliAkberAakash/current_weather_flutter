import 'package:current_weather_design_system/styles/util/extensions.dart';
import 'package:flutter/material.dart';

class WeatherInfoLineWidget extends StatelessWidget {
  final String property;
  final String value;

  const WeatherInfoLineWidget({
    super.key,
    required this.property,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Row(
      children: [
        Text(
          "$property: $value",
          style: theme.textTheme.titleMedium,
        ),
      ],
    );
  }
}
