import 'package:current_weather/app/routes.dart';
import 'package:flutter/material.dart';

import 'di/di.dart';

void main() {
  setup();
  runApp(MaterialApp.router(routerConfig: router));
}
