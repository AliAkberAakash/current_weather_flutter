import 'package:current_weather/features/current_weather/data/network/dto/current_weather_response.dart';
import 'package:current_weather/features/current_weather/domain/entity/weather_details_entity.dart';
import 'package:current_weather/features/current_weather/util/measurement_unit.dart';

abstract class WeatherDetailsEntityMapper {
  WeatherDetailsEntity mapFromWeeklyWeatherResponse(
    final CurrentWeatherResponse response,
    final MeasurementUnit unit,
  );
}

class WeatherDetailsEntityMapperImpl extends WeatherDetailsEntityMapper {
  @override
  WeatherDetailsEntity mapFromWeeklyWeatherResponse(
    final CurrentWeatherResponse response,
    final MeasurementUnit unit,
  ) {
    return WeatherDetailsEntity(
      dateTime: response.dateTime,
      temp: response.weatherDetails.temp,
      tempMin: response.weatherDetails.tempMin,
      tempMax: response.weatherDetails.tempMax,
      pressure: response.weatherDetails.pressure,
      humidity: response.weatherDetails.humidity,
      partOfDay: response.sys.partOfDay,
      weather: response.weather
          .map((response) => _mapFromWeather(response))
          .toList(),
      speed: response.wind.speed,
      unit: unit,
    );
  }

  WeatherEntity _mapFromWeather(
    final Weather response,
  ) {
    return WeatherEntity(
      name: response.name,
      description: response.description,
      icon: response.icon,
    );
  }
}
