import 'package:current_weather/features/weather_forecast/data/mapper/weather_details_entity_mapper.dart';
import 'package:current_weather/features/weather_forecast/data/network/dto/weather_query_request.dart';
import 'package:current_weather/features/weather_forecast/data/network/weather_network_data_source.dart';
import 'package:current_weather/features/weather_forecast/domain/entity/weather_details_entity.dart';
import 'package:current_weather/features/weather_forecast/domain/repository/weather_repository.dart';
import 'package:logger/logger.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherNetworkDataSource weatherNetworkDataSource;
  final WeatherDetailsEntityMapper mapper;
  final Logger logger;

  WeatherRepositoryImpl(
    this.weatherNetworkDataSource,
    this.mapper,
    this.logger,
  );

  @override
  Future<List<WeatherDetailsEntity>> getWeatherDetails(
      double lat, double lon) async {
    try {
      final request = WeatherQueryRequest(lat, lon);
      final response =
          await weatherNetworkDataSource.getWeatherResponse(request);

      return response
          .map((weatherDetails) =>
              mapper.mapFromWeeklyWeatherResponse(weatherDetails))
          .toList();
    } catch (e) {
      logger.d(e.toString());
      rethrow;
    }
  }
}
