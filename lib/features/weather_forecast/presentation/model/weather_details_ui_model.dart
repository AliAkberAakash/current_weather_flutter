import 'package:current_weather/features/weather_forecast/domain/entity/weather_details_entity.dart';
import 'package:current_weather/features/weather_forecast/util/temperature_unit.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

const _fullNameFormat = "EEEE";
const _shortNameFormat = "EEE";
const _humidityUnit = "%";
const _pressureUnit = "hPa";
const _windSpeedUnit = "km/h";
const _imageScalingSmall = "@2x";
const _imageScalingLarge = "@4x";
const _celsiusUnit = "°C";
const _fahrenheitUnit = "°F";

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
  final String smallIcon;
  final String bigIcon;
  final String windSpeed;
  final MeasurementUnit measurementUnit;
  final String temperatureUnit;

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
    required this.smallIcon,
    required this.bigIcon,
    required this.windSpeed,
    required this.measurementUnit,
    required this.temperatureUnit,
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
      smallIcon: entity.weather.isNotEmpty
          ? _getWeatherImageIcon(entity.weather[0].icon, _imageScalingSmall)
          : "",
      bigIcon: entity.weather.isNotEmpty
          ? _getWeatherImageIcon(entity.weather[0].icon, _imageScalingLarge)
          : "",
      windSpeed: "${entity.speed} $_windSpeedUnit",
      measurementUnit: entity.unit,
      temperatureUnit: _getMeasurementUnit(entity.unit),
    );
  }

  static String _getDayNameFromTimeStamp(int timestamp, String format) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return DateFormat(format).format(date);
  }

  static String _getWeatherImageIcon(String imageIcon, String imageScaling) {
    return "https://openweathermap.org/img/wn/$imageIcon$imageScaling.png";
  }

  static String _getMeasurementUnit(MeasurementUnit measurementUnit) {
    if (measurementUnit == MeasurementUnit.metric) {
      return _celsiusUnit;
    }

    return _fahrenheitUnit;
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
        smallIcon,
        windSpeed,
      ];
}
