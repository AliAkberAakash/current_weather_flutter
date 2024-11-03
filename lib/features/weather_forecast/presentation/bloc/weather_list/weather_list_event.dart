import 'package:equatable/equatable.dart';

abstract class WeatherListEvent extends Equatable{}

class WeatherListLoadEvent extends WeatherListEvent {
  @override
  List<Object?> get props => [];
}