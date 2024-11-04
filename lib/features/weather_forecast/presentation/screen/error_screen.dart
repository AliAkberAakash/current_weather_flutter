import 'package:current_weather_design_system/styles/util/extensions.dart';
import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final void Function() onTap;

  const ErrorScreen({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    final theme = context.theme;

    return Column(
      children: [
        Text(
          "Something went wrong",
          style: theme.textTheme.titleMedium,
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
