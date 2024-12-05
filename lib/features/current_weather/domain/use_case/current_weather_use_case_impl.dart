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
  Future<List<WeatherDetailsEntity>> getWeatherDetails({
    required final double lat,
    required final double lon,
    required final MeasurementUnit unit,
  }) async {
    final response = await repository.getWeatherDetails(
      lat: lat,
      lon: lon,
      unit: unit,
    );
    return _filterFirstWeatherDetailsPerDay(response);
  }

  List<WeatherDetailsEntity> _filterFirstWeatherDetailsPerDay(
    final List<WeatherDetailsEntity> weatherDetails,
  ) {
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
