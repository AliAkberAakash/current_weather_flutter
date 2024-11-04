import 'package:current_weather/features/current_weather/data/network/dto/weekly_weather_response.dart';
import 'package:current_weather/features/current_weather/domain/entity/weather_details_entity.dart';
import 'package:current_weather/features/current_weather/util/temperature_unit.dart';

abstract class WeatherDetailsEntityMapper {
  WeatherDetailsEntity mapFromWeeklyWeatherResponse(
    WeeklyWeatherResponse response,
    MeasurementUnit unit,
  );
}

class WeatherDetailsEntityMapperImpl extends WeatherDetailsEntityMapper {
  @override
  WeatherDetailsEntity mapFromWeeklyWeatherResponse(
    WeeklyWeatherResponse response,
    MeasurementUnit unit,
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
    Weather response,
  ) {
    return WeatherEntity(
      name: response.name,
      description: response.description,
      icon: response.icon,
    );
  }
}
