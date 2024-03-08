import 'package:flutter_notes_and_api_test/core/hive/hive_notes_service.dart';
import 'package:flutter_notes_and_api_test/data/repository/weather_repository.dart';
import 'package:flutter_notes_and_api_test/presentation/weather_screen/weather_bloc/weather_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../presentation/list_notes_screen/notes_bloc/list_screen_bloc.dart';

GetIt locator = GetIt.instance;

Future<void> initDI() async {
  locator.registerSingleton<HiveNotesService>(HiveNotesService());
  locator.registerSingleton<WeatherRepository>(WeatherRepository());

  locator.registerLazySingleton(
      () => ListScreenBloc(noteService: locator<HiveNotesService>()));

  locator.registerLazySingleton(
      () => WeatherBloc(repo: locator<WeatherRepository>()));
}
