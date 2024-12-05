import 'package:current_weather/features/current_weather/domain/entity/weather_details_entity.dart';
import 'package:current_weather/features/current_weather/util/measurement_unit.dart';

abstract class CurrentWeatherUseCase {
  Future<List<WeatherDetailsEntity>> getWeatherDetails({
    required final double lat,
    required final double lon,
    required final MeasurementUnit unit,
  });
}
