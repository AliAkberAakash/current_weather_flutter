import 'package:current_weather/di/di.dart';
import 'package:current_weather/features/weather_forecast/presentation/bloc/weather_details_cubit.dart';
import 'package:current_weather/features/weather_forecast/presentation/bloc/weather_list/weather_list_bloc.dart';
import 'package:current_weather/features/weather_forecast/presentation/bloc/weather_list/weather_list_event.dart';
import 'package:current_weather/features/weather_forecast/presentation/bloc/weather_list/weather_list_state.dart';
import 'package:current_weather/features/weather_forecast/presentation/screen/error_screen.dart';
import 'package:current_weather/features/weather_forecast/presentation/screen/weather_forecast_landscape_screen.dart';
import 'package:current_weather/features/weather_forecast/presentation/screen/weather_forecast_portrait_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherForecastScreen extends StatefulWidget {
  const WeatherForecastScreen({super.key});

  @override
  State<WeatherForecastScreen> createState() => _WeatherForecastScreenState();
}

class _WeatherForecastScreenState extends State<WeatherForecastScreen> {
  final WeatherListBloc weatherListBloc = getIt.get();
  final WeatherDetailsCubit weatherDetailsCubit = getIt.get();

  @override
  void initState() {
    weatherListBloc.add(WeatherListLoadEvent());
    super.initState();
  }

  @override
  void dispose() {
    weatherListBloc.close();
    weatherDetailsCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<WeatherListBloc, WeatherListState>(
            bloc: weatherListBloc,
            listener: (context, state) {
              if (state is WeatherListLoadedState &&
                  state.weatherDetailsUiModelList.isNotEmpty) {
                weatherDetailsCubit.updateWeatherDetails(
                  state.weatherDetailsUiModelList.first,
                );
              }
            },
          )
        ],
        child: BlocBuilder<WeatherListBloc, WeatherListState>(
          bloc: weatherListBloc,
          builder: (ctx, state) {
            if (state is WeatherListLoadedState) {
              return OrientationBuilder(
                builder: (ctx, orientation) {
                  if (orientation == Orientation.portrait) {
                    return WeatherForecastPortraitScreen(
                      weatherDetailsUiModelList:
                          state.weatherDetailsUiModelList,
                      weatherDetailsCubit: weatherDetailsCubit,
                      onRefresh: _onRefresh,
                    );
                  } else {
                    return WeatherForecastLandscapeScreen(
                      weatherDetailsUiModelList:
                          state.weatherDetailsUiModelList,
                      weatherDetailsCubit: weatherDetailsCubit,
                      onRefresh: _onRefresh,
                    );
                  }
                },
              );
            } else if (state is WeatherListLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Center(
                child: ErrorScreen(
                  onTap: _onRefresh,
                ),
              );
            }
          },
        ),
      ),
    );
  }

  void _onRefresh() {
    weatherListBloc.add(WeatherListLoadEvent());
  }
}
