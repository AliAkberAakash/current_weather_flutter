import 'package:current_weather/features/weather_forecast/domain/entity/weather_details_entity.dart';
import 'package:current_weather/features/weather_forecast/util/temperature_unit.dart';

abstract class WeatherForecastRepository {
  Future<List<WeatherDetailsEntity>> getWeatherDetails(
      double lat, double lon, MeasurementUnit unit);
}
