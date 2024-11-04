import 'package:current_weather/features/current_weather/data/mapper/weather_details_entity_mapper.dart';
import 'package:current_weather/features/current_weather/data/network/dto/weather_query_request.dart';
import 'package:current_weather/features/current_weather/data/network/weather_network_data_source.dart';
import 'package:current_weather/features/current_weather/domain/entity/weather_details_entity.dart';
import 'package:current_weather/features/current_weather/domain/repository/weather_forecast_repository.dart';
import 'package:current_weather/features/current_weather/util/temperature_unit.dart';
import 'package:logger/logger.dart';

class WeatherForecastRepositoryImpl implements WeatherForecastRepository {
  final WeatherNetworkDataSource _weatherNetworkDataSource;
  final WeatherDetailsEntityMapper _mapper;
  final Logger _logger;

  WeatherForecastRepositoryImpl(
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
      final request = WeatherQueryRequest(
        lat,
        lon,
        unit.name,
      );
      final response =
          await _weatherNetworkDataSource.getWeatherResponse(request);

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
