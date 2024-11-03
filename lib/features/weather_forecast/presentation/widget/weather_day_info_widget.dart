import 'package:current_weather_design_system/styles/util/extensions.dart';
import 'package:flutter/material.dart';

class WeatherDayInfoWidget extends StatelessWidget {
  const WeatherDayInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Card(
      color: theme.colorScheme.surfaceBright,
      child: Padding(
        padding: EdgeInsets.all(theme.spacingTokens.cwSpacing8),
        child: SizedBox(
          width: 180,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Fri",
                style: theme.textTheme.titleMedium,
              ),
              Image.network(
                "https://openweathermap.org/img/wn/10d@2x.png",
              ),
              Text(
                "14°/21°",
                style: theme.textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
