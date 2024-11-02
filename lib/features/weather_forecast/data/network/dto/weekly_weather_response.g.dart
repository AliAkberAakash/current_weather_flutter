// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weekly_weather_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeeklyWeatherResponse _$WeeklyWeatherResponseFromJson(
        Map<String, dynamic> json) =>
    WeeklyWeatherResponse(
      dateTime: (json['dt'] as num).toInt(),
      weatherDetails:
          WeatherDetails.fromJson(json['main'] as Map<String, dynamic>),
      weather: (json['weather'] as List<dynamic>)
          .map((e) => Weather.fromJson(e as Map<String, dynamic>))
          .toList(),
      wind: Wind.fromJson(json['wind'] as Map<String, dynamic>),
      sys: Sys.fromJson(json['sys'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WeeklyWeatherResponseToJson(
        WeeklyWeatherResponse instance) =>
    <String, dynamic>{
      'dt': instance.dateTime,
      'main': instance.weatherDetails,
      'weather': instance.weather,
      'wind': instance.wind,
      'sys': instance.sys,
    };

WeatherDetails _$WeatherDetailsFromJson(Map<String, dynamic> json) =>
    WeatherDetails(
      tempMin: (json['tempMin'] as num).toDouble(),
      tempMax: (json['tempMax'] as num).toDouble(),
      pressure: (json['pressure'] as num).toInt(),
      humidity: (json['humidity'] as num).toInt(),
    );

Map<String, dynamic> _$WeatherDetailsToJson(WeatherDetails instance) =>
    <String, dynamic>{
      'tempMin': instance.tempMin,
      'tempMax': instance.tempMax,
      'pressure': instance.pressure,
      'humidity': instance.humidity,
    };

Sys _$SysFromJson(Map<String, dynamic> json) => Sys(
      partOfDay: json['pod'] as String,
    );

Map<String, dynamic> _$SysToJson(Sys instance) => <String, dynamic>{
      'pod': instance.partOfDay,
    };

Weather _$WeatherFromJson(Map<String, dynamic> json) => Weather(
      name: json['main'] as String,
      description: json['description'] as String,
      icon: json['icon'] as String,
    );

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
      'main': instance.name,
      'description': instance.description,
      'icon': instance.icon,
    };

Wind _$WindFromJson(Map<String, dynamic> json) => Wind(
      speed: (json['speed'] as num).toDouble(),
    );

Map<String, dynamic> _$WindToJson(Wind instance) => <String, dynamic>{
      'speed': instance.speed,
    };
