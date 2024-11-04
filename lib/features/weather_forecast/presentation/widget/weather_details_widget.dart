import 'package:current_weather/features/weather_forecast/presentation/model/weather_details_ui_model.dart';
import 'package:current_weather/features/weather_forecast/presentation/widget/weather_info_line_widget.dart';
import 'package:current_weather_design_system/styles/util/extensions.dart';
import 'package:flutter/material.dart';

class WeatherDetailsWidget extends StatelessWidget {
  final WeatherDetailsUiModel weatherDetailsUiModel;
  final void Function() onTemperatureUnitChange;

  const WeatherDetailsWidget({
    super.key,
    required this.weatherDetailsUiModel,
    required this.onTemperatureUnitChange,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          weatherDetailsUiModel.dayNameFull,
          style: theme.textTheme.titleLarge,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              weatherDetailsUiModel.weatherCondition,
              style: theme.textTheme.titleMedium,
            ),
            Text(
              "°C",
              style: theme.textTheme.titleMedium!.copyWith(
                color: Colors.blue,
                decoration: TextDecoration.underline,
                decorationColor: Colors.blue,
              ),
            ),
          ],
        ),
        SizedBox(
          height: theme.spacingTokens.cwSpacing8,
        ),
        Image.network(
          weatherDetailsUiModel.smallIcon,
        ),
        Text(
          "${weatherDetailsUiModel.tempMax}°",
          style: theme.textTheme.displayLarge,
        ),
        Column(
          children: [
            WeatherInfoLineWidget(
              property: "Humidity",
              value: weatherDetailsUiModel.humidity,
            ),
            WeatherInfoLineWidget(
              property: "Pressure",
              value: weatherDetailsUiModel.pressure,
            ),
            WeatherInfoLineWidget(
              property: "Wind",
              value: weatherDetailsUiModel.windSpeed,
            ),
          ],
        ),
      ],
    );
  }
}
