part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetWeatherDataEvent extends WeatherEvent {
  final double lat;
  final double lon;

  GetWeatherDataEvent({required this.lat, required this.lon});

  @override
  List<Object?> get props => [lat, lon];
}
