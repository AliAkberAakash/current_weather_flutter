import 'package:current_weather/features/weather_forecast/util/temperature_unit.dart';
import 'package:equatable/equatable.dart';

abstract class WeatherListEvent extends Equatable {}

class WeatherListLoadEvent extends WeatherListEvent {
  final double lat;
  final double lon;
  final MeasurementUnit unit;

  WeatherListLoadEvent({
    required this.lat,
    required this.lon,
    required this.unit,
  });

  @override
  List<Object?> get props => [];
}
