import 'dart:async';

import 'package:current_weather/core/exceptions/base_exception.dart';
import 'package:current_weather/features/weather_forecast/domain/use_case/weather_forecast_use_case.dart';
import 'package:current_weather/features/weather_forecast/presentation/bloc/weather_list/weather_list_event.dart';
import 'package:current_weather/features/weather_forecast/presentation/bloc/weather_list/weather_list_state.dart';
import 'package:current_weather/features/weather_forecast/presentation/model/weather_details_ui_model.dart';
import 'package:current_weather/features/weather_forecast/util/temperature_unit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherListBloc extends Bloc<WeatherListEvent, WeatherListState> {
  final WeatherForecastUseCase useCase;

  WeatherListBloc(this.useCase) : super(WeatherListLoadingState()) {
    on<WeatherListLoadEvent>(_onWeatherListLoadHandler);
    on<WeatherListChangeTemperatureEvent>(
        _onWeatherListChangeTemperatureHandler);
  }

  FutureOr<void> _onWeatherListLoadHandler(
    WeatherListLoadEvent event,
    Emitter<WeatherListState> emit,
  ) async {
    emit(WeatherListLoadingState());
    try {
      final List<WeatherDetailsUiModel> response = await _loadWeatherList(
        event.lat,
        event.lon,
        event.unit,
      );

      emit(WeatherListLoadedState(response));
    } catch (e) {
      if (e is BaseException) {
        emit(WeatherListErrorState(exception: e));
      } else {
        emit(WeatherListErrorState());
      }
    }
  }

  Future<List<WeatherDetailsUiModel>> _loadWeatherList(
    double lat,
    double lon,
    MeasurementUnit unit,
  ) async {
    final response = await useCase.getWeatherDetails(
      lat,
      lon,
      unit,
    );

    return response
        .map(
          (entity) => WeatherDetailsUiModel.fromWeatherDetailsEntity(entity),
        )
        .toList();
  }

  FutureOr<void> _onWeatherListChangeTemperatureHandler(
    WeatherListChangeTemperatureEvent event,
    Emitter<WeatherListState> emit,
  ) async {
    late final MeasurementUnit currentUnit;
    if (event.unit == MeasurementUnit.metric) {
      currentUnit = MeasurementUnit.imperial;
    } else {
      currentUnit = MeasurementUnit.metric;
    }

    final List<WeatherDetailsUiModel> response = await _loadWeatherList(
      event.lat,
      event.lon,
      currentUnit,
    );

    emit(WeatherListLoadedState(response));
  }
}
