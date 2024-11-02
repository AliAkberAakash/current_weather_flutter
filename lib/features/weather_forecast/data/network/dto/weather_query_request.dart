import 'package:equatable/equatable.dart';

class WeatherQueryRequest extends Equatable {
  final double lat;
  final double lon;

  const WeatherQueryRequest(this.lat, this.lon);

  @override
  List<Object?> get props => [
    lat,
    lon,
  ];
}