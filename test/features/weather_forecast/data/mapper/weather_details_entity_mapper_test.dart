import 'package:current_weather/features/current_weather/data/mapper/weather_details_entity_mapper.dart';
import 'package:current_weather/features/current_weather/data/network/dto/weekly_weather_response.dart';
import 'package:current_weather/features/current_weather/util/temperature_unit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('WeatherDetailsEntityMapperImpl', () {
    final mapper = WeatherDetailsEntityMapperImpl();

    test(
        'mapFromWeeklyWeatherResponse should map WeeklyWeatherResponse to WeatherDetailsEntity',
        () {
      const weeklyWeatherResponse = WeeklyWeatherResponse(
        dateTime: 1234567890,
        weatherDetails: WeatherDetails(
          tempMin: 15.0,
          tempMax: 25.0,
          pressure: 1012,
          humidity: 85,
        ),
        weather: [
          Weather(name: "Clear", description: "clear sky", icon: "01d"),
        ],
        wind: Wind(speed: 5.0),
        sys: Sys(partOfDay: "d"),
      );

      final result = mapper.mapFromWeeklyWeatherResponse(
        weeklyWeatherResponse,
        MeasurementUnit.metric,
      );

      expect(result.dateTime, equals(1234567890));
      expect(result.tempMin, equals(15.0));
      expect(result.tempMax, equals(25.0));
      expect(result.pressure, equals(1012));
      expect(result.humidity, equals(85));
      expect(result.partOfDay, equals("d"));
      expect(result.speed, equals(5.0));

      expect(result.weather.length, equals(1));
      expect(result.weather.first.name, equals("Clear"));
      expect(result.weather.first.description, equals("clear sky"));
      expect(result.weather.first.icon, equals("01d"));
    });
  });
}
