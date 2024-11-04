import 'package:current_weather/features/current_weather/data/mapper/weather_details_entity_mapper.dart';
import 'package:current_weather/features/current_weather/data/network/current_weather_network_data_source.dart';
import 'package:current_weather/features/current_weather/domain/entity/weather_details_entity.dart';
import 'package:current_weather/features/current_weather/domain/repository/current_weather_repository.dart';
import 'package:current_weather/features/current_weather/util/temperature_unit.dart';
import 'package:logger/logger.dart';

class CurrentWeatherRepositoryImpl implements CurrentWeatherRepository {
  final CurrentWeatherNetworkDataSource _weatherNetworkDataSource;
  final WeatherDetailsEntityMapper _mapper;
  final Logger _logger;

  CurrentWeatherRepositoryImpl(
    this._weatherNetworkDataSource,
    this._mapper,
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
            (weatherDetails) => _mapper.mapFromWeeklyWeatherResponse(
              weatherDetails,
              unit,
            ),
          )
          .toList();
    } catch (e) {
      _logger.d(e.toString());
      rethrow;
    }
  }
}
