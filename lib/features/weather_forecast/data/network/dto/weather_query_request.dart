import 'package:equatable/equatable.dart';

class WeatherQueryRequest extends Equatable {
  final double lat;
  final double lon;
  final String unit;

  const WeatherQueryRequest(this.lat, this.lon, this.unit);

  @override
  List<Object?> get props => [
        lat,
        lon,
        unit,
      ];
}
