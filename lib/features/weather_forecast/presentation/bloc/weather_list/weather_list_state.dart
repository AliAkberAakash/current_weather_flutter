import 'package:current_weather/features/weather_forecast/presentation/bloc/error_keys.dart';
import 'package:current_weather/features/weather_forecast/presentation/model/weather_details_ui_model.dart';
import 'package:equatable/equatable.dart';

abstract class WeatherListState extends Equatable {}

class WeatherListLoadingState extends WeatherListState {
  @override
  List<Object?> get props => [];
}

class WeatherListLoadedState extends WeatherListState {
  final List<WeatherDetailsUiModel> weatherDetailsUiModelList;

  WeatherListLoadedState(this.weatherDetailsUiModelList);

  @override
  List<Object?> get props => [weatherDetailsUiModelList];
}

class WeatherListErrorState extends WeatherListState {
  final ErrorKey errorKey;

  WeatherListErrorState({
    required this.errorKey,
  });

  @override
  List<Object?> get props => [errorKey];
}
