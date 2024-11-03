import 'package:current_weather_design_system/styles/util/extensions.dart';
import 'package:flutter/material.dart';

class WeatherInfoLineWidget extends StatelessWidget {
  final String property;
  final String value;
  final String unit;

  const WeatherInfoLineWidget({
    super.key,
    required this.property,
    required this.value,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Row(
      children: [
        Text(
          "$property: $value $unit",
          style: theme.textTheme.titleSmall,
        ),
      ],
    );
  }
}
