import 'package:current_weather/features/weather_forecast/data/network/dto/weekly_weather_response.dart';
import 'package:current_weather/features/weather_forecast/domain/entity/weather_details_entity.dart';

abstract class WeatherDetailsEntityMapper {
  WeatherEntity mapFromWeather(Weather response);

  WeatherDetailsEntity mapFromWeeklyWeatherResponse(
      WeeklyWeatherResponse response);
}

class WeatherDetailsEntityMapperImpl extends WeatherDetailsEntityMapper {
  @override
  WeatherDetailsEntity mapFromWeeklyWeatherResponse(
      WeeklyWeatherResponse response) {
    return WeatherDetailsEntity(
      dateTime: response.dateTime,
      tempMin: response.weatherDetails.tempMin,
      tempMax: response.weatherDetails.tempMax,
      pressure: response.weatherDetails.pressure,
      humidity: response.weatherDetails.humidity,
      partOfDay: response.sys.partOfDay,
      weather:
          response.weather.map((response) => mapFromWeather(response)).toList(),
      speed: response.wind.speed,
    );
  }

  @override
  WeatherEntity mapFromWeather(Weather response) {
    return WeatherEntity(
      name: response.name,
      description: response.description,
      icon: response.icon,
    );
  }
}
