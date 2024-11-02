import 'package:current_weather/features/weather_forecast/domain/entity/weather_details_entity.dart';

abstract class WeatherRepository {
  Future<List<WeatherDetailsEntity>> getWeatherDetails(double lat, double lon);
}
