import 'dart:async';

import 'package:current_weather/core/exceptions/base_exception.dart';
import 'package:current_weather/features/weather_forecast/domain/entity/weather_details_entity.dart';
import 'package:current_weather/features/weather_forecast/domain/use_case/weather_forecast_use_case.dart';
import 'package:current_weather/features/weather_forecast/presentation/bloc/weather_list/weather_list_event.dart';
import 'package:current_weather/features/weather_forecast/presentation/bloc/weather_list/weather_list_state.dart';
import 'package:current_weather/features/weather_forecast/presentation/model/weather_details_ui_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherListBloc extends Bloc<WeatherListEvent, WeatherListState> {
  final WeatherForecastUseCase useCase;

  WeatherListBloc(this.useCase) : super(WeatherListLoadingState()) {
    on<WeatherListLoadEvent>(_onWeatherListLoadHandler);
  }

  FutureOr<void> _onWeatherListLoadHandler(
      WeatherListLoadEvent event, Emitter<WeatherListState> emit) async {
    emit(WeatherListLoadingState());
    try {
      final List<WeatherDetailsEntity> response =
          await useCase.getWeatherDetails(
        52.490881,
        13.392895,
        "metric",
      );

      final List<WeatherDetailsUiModel> weatherDetailsUiModelList = response
          .map((entity) =>
              WeatherDetailsUiModel.fromWeatherDetailsEntity(entity))
          .toList();

      emit(WeatherListLoadedState(weatherDetailsUiModelList));
    } catch (e) {
      if (e is BaseException) {
        emit(WeatherListErrorState(exception: e));
      } else {
        emit(WeatherListErrorState());
      }
    }
  }
}
