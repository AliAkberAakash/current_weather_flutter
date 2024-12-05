import 'package:current_weather/features/current_weather/domain/entity/weather_details_entity.dart';
import 'package:current_weather/features/current_weather/util/measurement_unit.dart';

abstract class CurrentWeatherRepository {
  Future<List<WeatherDetailsEntity>> getWeatherDetails(
    final double lat,
    final double lon,
    final MeasurementUnit unit,
  );
}
