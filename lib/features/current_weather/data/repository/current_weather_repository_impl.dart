import 'package:current_weather/core/exceptions/base_exception.dart';
import 'package:current_weather/features/common/data/mapper/exception_to_error_mapper.dart';
import 'package:current_weather/features/current_weather/data/mapper/weather_details_entity_mapper.dart';
import 'package:current_weather/features/current_weather/data/network/current_weather_network_data_source.dart';
import 'package:current_weather/features/current_weather/domain/entity/weather_details_entity.dart';
import 'package:current_weather/features/current_weather/domain/repository/current_weather_repository.dart';
import 'package:current_weather/features/current_weather/util/measurement_unit.dart';
import 'package:logger/logger.dart';

class CurrentWeatherRepositoryImpl implements CurrentWeatherRepository {
  final CurrentWeatherNetworkDataSource _weatherNetworkDataSource;
  final WeatherDetailsEntityMapper _weatherDetailsEntityMapper;
  final ExceptionToErrorMapper _exceptionToErrorMapper;
  final Logger _logger;

  CurrentWeatherRepositoryImpl(
    this._weatherNetworkDataSource,
    this._weatherDetailsEntityMapper,
    this._exceptionToErrorMapper,
    this._logger,
  );

  @override
  Future<List<WeatherDetailsEntity>> getWeatherDetails(
    double lat,
    double lon,
    MeasurementUnit unit,
  ) async {
    try {
      final response = await _weatherNetworkDataSource.getWeatherResponse(
        lat,
        lon,
        unit.name,
      );

      return response
          .map(
            (weatherDetails) =>
                _weatherDetailsEntityMapper.mapFromWeeklyWeatherResponse(
              weatherDetails,
              unit,
            ),
          )
          .toList();
    } on BaseException catch (e) {
      _logger.d(e.toString());
      final error = _exceptionToErrorMapper.mapExceptionToError(e);
      throw error;
    } catch (e) {
      rethrow;
    }
  }
}
