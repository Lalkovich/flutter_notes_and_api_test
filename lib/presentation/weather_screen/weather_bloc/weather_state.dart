part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  @override
  List<Object?> get props => [];
}

class WeatherInitial extends WeatherState {}

class WeatherDataError extends WeatherState {
  final String message;

  WeatherDataError({required this.message});

  @override
  List<Object?> get props => [message];
}

class WeatherDataIsLoading extends WeatherState {}

class WeatherDataIsLoaded extends WeatherState {
  final WeatherModel model;

  WeatherDataIsLoaded({required this.model});

  @override
  List<Object?> get props => [model];
}
