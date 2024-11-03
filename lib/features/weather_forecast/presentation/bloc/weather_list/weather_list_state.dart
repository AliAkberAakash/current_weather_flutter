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
  WeatherListErrorState();

  @override
  List<Object?> get props => [];
}
