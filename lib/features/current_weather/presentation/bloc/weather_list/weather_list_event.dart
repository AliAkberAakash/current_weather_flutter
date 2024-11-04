import 'package:current_weather/features/current_weather/util/measurement_unit.dart';
import 'package:equatable/equatable.dart';

abstract class WeatherListEvent extends Equatable {}

class WeatherListLoadEvent extends WeatherListEvent {
  final double lat;
  final double lon;
  final MeasurementUnit unit;

  WeatherListLoadEvent({
    this.lat = 10.2,
    this.lon = -20.3,
    this.unit = MeasurementUnit.metric,
  });

  @override
  List<Object?> get props => [lat, lon, unit];
}

class WeatherListChangeTemperatureEvent extends WeatherListEvent {
  final double lat;
  final double lon;
  final MeasurementUnit unit;

  WeatherListChangeTemperatureEvent({
    this.lat = 10.2,
    this.lon = -20.3,
    required this.unit,
  });

  @override
  List<Object?> get props => [lat, lon, unit];
}
