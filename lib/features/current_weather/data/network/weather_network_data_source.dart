import 'package:current_weather/features/current_weather/data/network/dto/weekly_weather_response.dart';

abstract class WeatherNetworkDataSource {
  Future<List<WeeklyWeatherResponse>> getWeatherResponse(
    double lat,
    double lon,
    String unit,
  );
}
