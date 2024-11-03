import 'package:current_weather/di/di.dart';
import 'package:current_weather/features/weather_forecast/presentation/bloc/weather_list/weather_list_bloc.dart';
import 'package:current_weather/features/weather_forecast/presentation/bloc/weather_list/weather_list_event.dart';
import 'package:current_weather/features/weather_forecast/presentation/bloc/weather_list/weather_list_state.dart';
import 'package:current_weather/features/weather_forecast/presentation/weather_forecast_portrait_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherForecastScreen extends StatelessWidget {
  const WeatherForecastScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Friday",
        ),
      ),
      body: BlocProvider(
        create: (context) => getIt.get<WeatherListBloc>()
          ..add(
            WeatherListLoadEvent(),
          ),
        child: BlocBuilder<WeatherListBloc, WeatherListState>(
          builder: (ctx, state) {
            if (state is WeatherListLoadedState) {
              return WeatherForecastPortraitScreen(
                weatherDetailsUiModelList: state.weatherDetailsUiModelList,
              );
            } else if (state is WeatherListLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return const Text("Error");
            }
          },
        ),
      ),
    );
  }
}
