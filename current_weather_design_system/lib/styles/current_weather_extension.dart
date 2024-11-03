import "package:current_weather_design_system/styles/theme/theme.dart";
import "package:current_weather_design_system/tokens/border_radius/border_radius_tokens.dart";
import "package:current_weather_design_system/tokens/border_width/border_width_tokens.dart";
import "package:current_weather_design_system/tokens/elevation/elevation_tokens.dart";
import "package:current_weather_design_system/tokens/icon_size/icon_size_tokens.dart";
import "package:current_weather_design_system/tokens/opacity/opacity_tokens.dart";
import "package:current_weather_design_system/tokens/spacing/spacing_tokens.dart";
import "package:flutter/material.dart";

class CurrentWeatherExtensions extends ThemeExtension<CurrentWeatherExtensions> {
  final CurrentWeatherScheme colorScheme;
  final TextTheme textTheme;
  late final ElevationTokens elevationTokens;
  late final BorderRadiusTokens borderRadiusTokens;
  late final BorderWidthTokens borderWidthTokens;
  late final OpacityTokens opacityTokens;
  late final SpacingTokens spacingTokens;
  late final IconSizeTokens iconSizeTokens;

  CurrentWeatherExtensions({
    required this.colorScheme,
    required this.textTheme,
  }) {
    elevationTokens = ElevationTokens();
    borderRadiusTokens = BorderRadiusTokens();
    borderWidthTokens = BorderWidthTokens();
    opacityTokens = OpacityTokens();
    spacingTokens = SpacingTokens();
    iconSizeTokens = IconSizeTokens();
  }

  @override
  CurrentWeatherExtensions copyWith({
    CurrentWeatherScheme? colorScheme,
  }) {
    return CurrentWeatherExtensions(
      textTheme: textTheme,
      colorScheme: colorScheme ?? this.colorScheme,
    );
  }

  @override
  CurrentWeatherExtensions lerp(
      covariant ThemeExtension<CurrentWeatherExtensions>? other, double t) {
    if (other is! CurrentWeatherExtensions) {
      return this;
    }

    return CurrentWeatherExtensions(
      textTheme: textTheme,
      colorScheme: colorScheme.lerp(other.colorScheme, t),
    );
  }
}
