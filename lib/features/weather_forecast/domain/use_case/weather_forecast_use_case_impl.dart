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
  ) async {
    final response = await repository.getWeatherDetails(lat, lon, unit);
    return _filterFirstWeatherDetailsPerDay(response);
  }

  List<WeatherDetailsEntity> _filterFirstWeatherDetailsPerDay(
      List<WeatherDetailsEntity> weatherDetails) {
    Map<String, WeatherDetailsEntity> firstWeatherDetailsPerDay = {};

    for (var entity in weatherDetails) {
      DateTime date =
          DateTime.fromMillisecondsSinceEpoch(entity.dateTime * 1000);
      String dayKey = "${date.year}-${date.month}-${date.day}";

      if (!firstWeatherDetailsPerDay.containsKey(dayKey)) {
        firstWeatherDetailsPerDay[dayKey] = entity;
      }
    }

    return firstWeatherDetailsPerDay.values.toList();
  }
}
