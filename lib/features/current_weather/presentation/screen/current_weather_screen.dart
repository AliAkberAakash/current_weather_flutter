import 'package:current_weather/features/current_weather/presentation/bloc/weather_details_cubit.dart';
import 'package:current_weather/features/current_weather/presentation/bloc/weather_list/weather_list_bloc.dart';
import 'package:current_weather/features/current_weather/presentation/bloc/weather_list/weather_list_event.dart';
import 'package:current_weather/features/current_weather/presentation/bloc/weather_list/weather_list_state.dart';
import 'package:current_weather/features/current_weather/presentation/screen/current_weather_error_screen.dart';
import 'package:current_weather/features/current_weather/presentation/screen/current_weather_landscape_screen.dart';
import 'package:current_weather/features/current_weather/presentation/screen/current_weather_loading_screen.dart';
import 'package:current_weather/features/current_weather/presentation/screen/current_weather_portrait_screen.dart';
import 'package:current_weather/features/current_weather/util/measurement_unit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrentWeatherScreen extends StatefulWidget {
  const CurrentWeatherScreen({super.key});

  @override
  State<CurrentWeatherScreen> createState() => _CurrentWeatherScreenState();
}

class _CurrentWeatherScreenState extends State<CurrentWeatherScreen> {
  @override
  void initState() {
    _loadWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<WeatherListBloc, WeatherListState>(
        listener: (ctx, state) {
          if (state is WeatherListLoadedState &&
              state.weatherDetailsUiModelList.isNotEmpty) {
            context.read<WeatherDetailsCubit>().updateWeatherDetails(
                  state.weatherDetailsUiModelList.first,
                );
          }
        },
        builder: (ctx, state) {
          if (state is WeatherListLoadedState) {
            return OrientationBuilder(
              builder: (ctx, orientation) {
                if (orientation == Orientation.portrait) {
                  return CurrentWeatherPortraitScreen(
                    weatherDetailsUiModelList: state.weatherDetailsUiModelList,
                    onRefresh: _loadWeather,
                    onTemperatureUnitChange: _changeTemperatureUnit,
                  );
                } else {
                  return CurrentWeatherLandscapeScreen(
                    weatherDetailsUiModelList: state.weatherDetailsUiModelList,
                    onRefresh: _loadWeather,
                    onTemperatureUnitChange: _changeTemperatureUnit,
                  );
                }
              },
            );
          } else if (state is WeatherListLoadingState) {
            return CurrentWeatherLoadingScreen();
          } else {
            return Center(
              child: CurrentWeatherErrorScreen(
                onTap: _loadWeather,
              ),
            );
          }
        },
      ),
    );
  }

  void _changeTemperatureUnit(MeasurementUnit unit) {
    context.read<WeatherListBloc>().add(
          WeatherListChangeTemperatureEvent(
            unit: unit,
          ),
        );
  }

  void _loadWeather() {
    context.read<WeatherListBloc>().add(
          WeatherListLoadEvent(),
        );
  }
}
