import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notes_and_api_test/data/repository/model/weather_model.dart';

import '../../../data/repository/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository repo;
  WeatherBloc({required this.repo}) : super(WeatherInitial()) {
    on<GetWeatherDataEvent>(_getWeatherData);
  }

  void _getWeatherData(
      GetWeatherDataEvent event, Emitter<WeatherState> emit) async {
    emit(WeatherDataIsLoading());
    try {
      final result = await repo.fetchWeather(event.lat, event.lon);
      emit(WeatherDataIsLoaded(model: result));
    } catch (e) {
      emit(WeatherDataError(message: e.toString()));
    }
  }
}
