import 'package:current_weather/features/weather_forecast/domain/entity/weather_details_entity.dart';
import 'package:current_weather/features/weather_forecast/presentation/model/weather_details_ui_model.dart';
import 'package:current_weather/features/weather_forecast/util/temperature_unit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

void main() {
  test('WeatherDetailsUiModel fromWeatherDetailsEntity maps correctly', () {
    const timestamp = 1661871600; // Unix timestamp for a specific date
    final dateFullName = DateFormat("EEEE")
        .format(DateTime.fromMillisecondsSinceEpoch(timestamp * 1000));
    final dateShortName = DateFormat("EEE")
        .format(DateTime.fromMillisecondsSinceEpoch(timestamp * 1000));
    const weatherEntity = WeatherEntity(
      name: 'Clear',
      description: 'clear sky',
      icon: '01d',
    );
    const weatherDetailsEntity = WeatherDetailsEntity(
      dateTime: timestamp,
      tempMin: 18.5,
      tempMax: 25.3,
      pressure: 1013,
      humidity: 60,
      partOfDay: 'day',
      weather: [weatherEntity],
      speed: 15.0,
      unit: MeasurementUnit.metric,
    );

    final uiModel =
        WeatherDetailsUiModel.fromWeatherDetailsEntity(weatherDetailsEntity);

    expect(uiModel.dayNameFull, dateFullName);
    expect(uiModel.dayNameShort, dateShortName);
    expect(uiModel.tempMin, '18.5');
    expect(uiModel.tempMax, '25.3');
    expect(uiModel.pressure, '1013 hPa');
    expect(uiModel.humidity, '60 %');
    expect(uiModel.partOfDay, 'day');
    expect(uiModel.weatherCondition, 'Clear');
    expect(uiModel.description, 'clear sky');
    expect(uiModel.smallIcon, 'https://openweathermap.org/img/wn/01d@2x.png');
    expect(uiModel.windSpeed, '15.0 km/h');
    expect(uiModel.measurementUnit, MeasurementUnit.metric);
    expect(uiModel.temperatureUnit, "°C");
  });
}
