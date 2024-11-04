import 'package:current_weather/features/current_weather/presentation/model/weather_details_ui_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherDetailsCubit extends Cubit<WeatherDetailsUiModel?> {
  WeatherDetailsCubit() : super(null);

  void updateWeatherDetails(WeatherDetailsUiModel weatherDetailsUiModel) {
    emit(weatherDetailsUiModel);
  }
}
