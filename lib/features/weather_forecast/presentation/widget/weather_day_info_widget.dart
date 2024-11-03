import 'package:current_weather/features/weather_forecast/presentation/model/weather_details_ui_model.dart';
import 'package:current_weather_design_system/styles/util/extensions.dart';
import 'package:flutter/material.dart';

class WeatherDayInfoWidget extends StatelessWidget {
  final WeatherDetailsUiModel uiModel;
  final void Function(WeatherDetailsUiModel) onTap;

  const WeatherDayInfoWidget({
    super.key,
    required this.uiModel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Card(
      clipBehavior: Clip.antiAlias,
      color: theme.colorScheme.surfaceBright,
      child: InkWell(
        onTap: () => onTap(uiModel),
        child: Padding(
          padding: EdgeInsets.all(theme.spacingTokens.cwSpacing8),
          child: SizedBox(
            width: 180,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  uiModel.dayNameShort,
                  style: theme.textTheme.titleMedium,
                ),
                Image.network(
                  uiModel.icon,
                ),
                Text(
                  "${uiModel.tempMax}°/${uiModel.tempMax}°",
                  style: theme.textTheme.titleMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
