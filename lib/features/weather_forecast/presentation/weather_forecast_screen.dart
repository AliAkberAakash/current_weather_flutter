import 'package:current_weather/features/weather_forecast/presentation/widget/weather_day_info_widget.dart';
import 'package:current_weather/features/weather_forecast/presentation/widget/weather_details_widget.dart';
import 'package:current_weather_design_system/styles/util/extensions.dart';
import 'package:flutter/material.dart';

class WeatherForecastScreen extends StatelessWidget {
  const WeatherForecastScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Friday",
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(
          theme.spacingTokens.cwSpacing16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const Expanded(
              child: WeatherDetailsWidget(),
            ),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return const WeatherDayInfoWidget();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
