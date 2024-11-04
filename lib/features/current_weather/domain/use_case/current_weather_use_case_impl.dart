import 'package:current_weather/features/current_weather/domain/entity/weather_details_entity.dart';
import 'package:current_weather/features/current_weather/domain/repository/current_weather_repository.dart';
import 'package:current_weather/features/current_weather/domain/use_case/current_weather_use_case.dart';
import 'package:current_weather/features/current_weather/util/measurement_unit.dart';

class CurrentWeatherUseCaseImpl implements CurrentWeatherUseCase {
  final CurrentWeatherRepository repository;

  CurrentWeatherUseCaseImpl(
    this.repository,
  );

  @override
  Future<List<WeatherDetailsEntity>> getWeatherDetails(
    double lat,
    double lon,
    MeasurementUnit unit,
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
