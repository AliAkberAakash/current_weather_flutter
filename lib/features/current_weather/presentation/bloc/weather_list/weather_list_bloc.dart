import 'dart:async';

import 'package:current_weather/features/common/domain/error/error.dart';
import 'package:current_weather/features/current_weather/domain/use_case/current_weather_use_case.dart';
import 'package:current_weather/features/current_weather/presentation/bloc/weather_list/weather_list_event.dart';
import 'package:current_weather/features/current_weather/presentation/bloc/weather_list/weather_list_state.dart';
import 'package:current_weather/features/current_weather/presentation/model/weather_details_ui_model.dart';
import 'package:current_weather/features/current_weather/util/measurement_unit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherListBloc extends Bloc<WeatherListEvent, WeatherListState> {
  final CurrentWeatherUseCase useCase;

  WeatherListBloc(this.useCase) : super(WeatherListLoadingState()) {
    on<WeatherListLoadEvent>(_onWeatherListLoadHandler);
    on<WeatherListChangeTemperatureEvent>(
        _onWeatherListChangeTemperatureHandler);
  }

  FutureOr<void> _onWeatherListLoadHandler(
    final WeatherListLoadEvent event,
    final Emitter<WeatherListState> emit,
  ) async {
    emit(WeatherListLoadingState());
    try {
      final List<WeatherDetailsUiModel> response = await _loadWeatherList(
        lat: event.lat,
        lon: event.lon,
        unit: event.unit,
      );

      emit(WeatherListLoadedState(response));
    } on BaseError catch (e) {
      emit(
        WeatherListErrorState(
          error: e,
        ),
      );
    } catch (e) {
      emit(
        WeatherListErrorState(
          error: CommonError(),
        ),
      );
    }
  }

  Future<List<WeatherDetailsUiModel>> _loadWeatherList({
    required final double lat,
    required final double lon,
    required final MeasurementUnit unit,
  }) async {
    final response = await useCase.getWeatherDetails(
      lat: lat,
      lon: lon,
      unit: unit,
    );

    return response
        .map(
          (entity) => WeatherDetailsUiModel.fromWeatherDetailsEntity(entity),
        )
        .toList();
  }

  FutureOr<void> _onWeatherListChangeTemperatureHandler(
    final WeatherListChangeTemperatureEvent event,
    final Emitter<WeatherListState> emit,
  ) async {
    try {
      late final MeasurementUnit currentUnit;
      if (event.unit == MeasurementUnit.metric) {
        currentUnit = MeasurementUnit.imperial;
      } else {
        currentUnit = MeasurementUnit.metric;
      }

      final List<WeatherDetailsUiModel> response = await _loadWeatherList(
        lat: event.lat,
        lon: event.lon,
        unit: currentUnit,
      );

      emit(WeatherListLoadedState(response));
    } on BaseError catch (e) {
      emit(
        WeatherListErrorState(
          error: e,
        ),
      );
    } catch (e) {
      emit(
        WeatherListErrorState(
          error: CommonError(),
        ),
      );
    }
  }
}
