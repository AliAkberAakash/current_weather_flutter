import 'package:current_weather/features/current_weather/data/network/dto/current_weather_response.dart';

abstract class CurrentWeatherNetworkDataSource {
  Future<List<CurrentWeatherResponse>> getWeatherResponse(
    double lat,
    double lon,
    String unit,
  );
}
