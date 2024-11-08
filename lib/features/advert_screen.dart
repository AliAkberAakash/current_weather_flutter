import 'package:flutter/material.dart';

class AdvertScreen extends StatelessWidget {
  const AdvertScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //final theme = context.theme;
    return Scaffold(
      body: Center(
        child: Text(
          "This is from the deeplink!",
          //style: theme.textTheme.titleMedium,
        ),
      ),
    );
  }
}
