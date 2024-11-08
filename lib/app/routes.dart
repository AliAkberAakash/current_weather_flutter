import 'package:current_weather/app/current_weather_app.dart';
import 'package:current_weather/features/advert_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (_, __) => CurrentWeatherApp(),
      routes: [
        GoRoute(
          path: "advert",
          builder: (_, __) => AdvertScreen(),
        ),
      ],
    ),
  ],
);
