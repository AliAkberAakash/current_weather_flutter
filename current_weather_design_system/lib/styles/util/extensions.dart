import 'package:current_weather_design_system/styles/current_weather_extension.dart';
import 'package:flutter/material.dart';

extension CurrentWeatherThemeExtension on BuildContext {
  CurrentWeatherExtensions get theme => Theme.of(this).extension<CurrentWeatherExtensions>()!;
}
