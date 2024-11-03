import 'package:current_weather/features/weather_forecast/presentation/widget/weather_info_line_widget.dart';
import 'package:current_weather_design_system/styles/util/extensions.dart';
import 'package:flutter/material.dart';

class WeatherDetailsWidget extends StatelessWidget {
  const WeatherDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Showers",
            style: theme.textTheme.titleMedium,
          ),
        ),
        SizedBox(
          height: theme.spacingTokens.cwSpacing8,
        ),
        Image.network(
          "https://openweathermap.org/img/wn/10d@4x.png",
        ),
        Text(
          "20°",
          style: theme.textTheme.displayLarge,
        ),
        const Column(
          children: [
            WeatherInfoLineWidget(
              property: "Humidity",
              value: "67",
              unit: "%",
            ),
            WeatherInfoLineWidget(
              property: "Pressure",
              value: "1009",
              unit: "hpa",
            ),
            WeatherInfoLineWidget(
              property: "Wind",
              value: "23",
              unit: "km/h",
            ),
          ],
        ),
        SizedBox(
          height: theme.spacingTokens.cwSpacing32,
        ),
      ],
    );
  }
}
