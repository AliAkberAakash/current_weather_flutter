import 'package:current_weather/di/di.dart';
import 'package:current_weather/features/current_weather/presentation/bloc/weather_details_cubit.dart';
import 'package:current_weather/features/current_weather/presentation/bloc/weather_list/weather_list_bloc.dart';
import 'package:current_weather/features/current_weather/presentation/screen/current_weather_screen.dart';
import 'package:current_weather_design_system/styles/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrentWeatherApp extends StatelessWidget {
  const CurrentWeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Current Weather',
      theme: theme.light(),
      darkTheme: theme.dark(),
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider<WeatherListBloc>(
            create: (ctx) => getIt.get<WeatherListBloc>(),
          ),
          BlocProvider<WeatherDetailsCubit>(
            create: (ctx) => getIt.get<WeatherDetailsCubit>(),
          ),
        ],
        child: const CurrentWeatherScreen(),
      ),
    );
  }
}
