import 'package:current_weather/features/weather_forecast/domain/entity/weather_details_entity.dart';
import 'package:current_weather/features/weather_forecast/domain/repository/weather_forecast_repository.dart';
import 'package:current_weather/features/weather_forecast/domain/use_case/weather_forecast_use_case.dart';

class WeatherForecastUseCaseImpl implements WeatherForecastUseCase {
  final WeatherForecastRepository repository;

  WeatherForecastUseCaseImpl(
    this.repository,
  );

  @override
  Future<List<WeatherDetailsEntity>> getWeatherDetails(
    double lat,
    double lon,
    String unit,
  ) {
    return repository.getWeatherDetails(lat, lon, unit);
  }
}
