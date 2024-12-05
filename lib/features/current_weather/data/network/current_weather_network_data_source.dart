import 'package:current_weather/features/current_weather/data/network/dto/current_weather_response.dart';

abstract class CurrentWeatherNetworkDataSource {
  Future<List<CurrentWeatherResponse>> getWeatherResponse({
    required final double lat,
    required final double lon,
    required final String unit,
  });
}
