import 'package:current_weather_design_system/styles/util/extensions.dart';
import 'package:flutter/material.dart';

class CurrentWeatherErrorScreen extends StatelessWidget {
  final void Function() onTap;

  const CurrentWeatherErrorScreen({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Something went wrong",
          style: theme.textTheme.titleMedium,
        ),
        SizedBox(
          height: theme.spacingTokens.cwSpacing32,
        ),
        MaterialButton(
          onPressed: onTap,
          color: theme.colorScheme.primaryContainer,
          child: const Text("Retry"),
        ),
      ],
    );
  }
}
