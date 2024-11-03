import 'package:current_weather/features/weather_forecast/domain/entity/weather_details_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

const _fullNameFormat = "EEEE";
const _shortNameFormat = "EEE";
const _humidityUnit = "%";
const _pressureUnit = "hPa";
const _windSpeedUnit = "km/h";

class WeatherDetailsUiModel extends Equatable {
  final String dayNameFull;
  final String dayNameShort;
  final String tempMin;
  final String tempMax;
  final String pressure;
  final String humidity;
  final String partOfDay;
  final String weatherCondition;
  final String description;
  final String icon;
  final String windSpeed;

  const WeatherDetailsUiModel({
    required this.dayNameFull,
    required this.dayNameShort,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    required this.partOfDay,
    required this.weatherCondition,
    required this.description,
    required this.icon,
    required this.windSpeed,
  });

  factory WeatherDetailsUiModel.fromWeatherDetailsEntity(
    WeatherDetailsEntity entity,
  ) {
    return WeatherDetailsUiModel(
      dayNameFull: _getDayNameFromTimeStamp(
        entity.dateTime,
        _fullNameFormat,
      ),
      dayNameShort: _getDayNameFromTimeStamp(
        entity.dateTime,
        _shortNameFormat,
      ),
      tempMin: entity.tempMin.toString(),
      tempMax: entity.tempMax.toString(),
      pressure: "${entity.pressure} $_pressureUnit",
      humidity: "${entity.humidity} $_humidityUnit",
      partOfDay: entity.partOfDay,
      weatherCondition: entity.weather.isNotEmpty ? entity.weather[0].name : "",
      description:
          entity.weather.isNotEmpty ? entity.weather[0].description : "",
      icon: entity.weather.isNotEmpty
          ? _getWeatherImageUrl(entity.weather[0].icon)
          : "",
      windSpeed: "${entity.speed} $_windSpeedUnit",
    );
  }

  static String _getDayNameFromTimeStamp(int timestamp, String format) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return DateFormat(format).format(date);
  }

  static String _getWeatherImageUrl(String imageIcon) {
    return "https://openweathermap.org/img/wn/$imageIcon@2x.png";
  }

  @override
  List<Object?> get props => [
        dayNameFull,
        dayNameShort,
        tempMin,
        tempMax,
        pressure,
        humidity,
        partOfDay,
        weatherCondition,
        description,
        icon,
        windSpeed,
      ];
}
