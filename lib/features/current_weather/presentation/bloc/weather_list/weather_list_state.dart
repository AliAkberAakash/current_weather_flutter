import 'package:current_weather/features/current_weather/presentation/bloc/error_keys.dart';
import 'package:current_weather/features/current_weather/presentation/model/weather_details_ui_model.dart';
import 'package:equatable/equatable.dart';

sealed class WeatherListState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class WeatherListLoadingState extends WeatherListState {}

final class WeatherListLoadedState extends WeatherListState {
  final List<WeatherDetailsUiModel> weatherDetailsUiModelList;

  WeatherListLoadedState(this.weatherDetailsUiModelList);

  @override
  List<Object?> get props => [weatherDetailsUiModelList];
}

final class WeatherListErrorState extends WeatherListState {
  final ErrorKey errorKey;

  WeatherListErrorState({
    required this.errorKey,
  });

  @override
  List<Object?> get props => [errorKey];
}
