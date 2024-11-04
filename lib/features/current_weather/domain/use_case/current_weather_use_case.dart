import 'package:current_weather/features/current_weather/domain/entity/weather_details_entity.dart';
import 'package:current_weather/features/current_weather/util/temperature_unit.dart';

abstract class CurrentWeatherUseCase {
  Future<List<WeatherDetailsEntity>> getWeatherDetails(
    double lat,
    double lon,
    MeasurementUnit unit,
  );
}
