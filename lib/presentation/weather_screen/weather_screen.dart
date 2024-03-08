import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notes_and_api_test/presentation/weather_screen/weather_bloc/weather_bloc.dart';

import '../../core/di/injection_container.dart';

class WeatherScreen extends StatelessWidget {
  WeatherScreen({super.key});

  final bloc = locator.get<WeatherBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc..add(GetWeatherDataEvent(lat: 49.2, lon: 28.4)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Weather Data'),
          centerTitle: false,
        ),
        body: const _View(),
      ),
    );
  }
}

class _View extends StatefulWidget {
  const _View({super.key});

  @override
  State<_View> createState() => _ViewState();
}

class _ViewState extends State<_View> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is WeatherDataIsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is WeatherDataIsLoaded) {
          return SingleChildScrollView(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('City: ${state.model.name}'),
                  Text('Temperature: ${state.model.main.temp.toString()}°C'),
                  Text('Weather: ${state.model.weather[0].main}'),
                  Text('Description: ${state.model.weather[0].description}'),
                  Text('Humidity: ${state.model.main.humidity.toString()}%'),
                  Text('Wind Speed: ${state.model.wind.speed.toString()} m/s'),
                  const SizedBox(height: 20),
                  const Text('Additional Info:'),
                  Text('Pressure: ${state.model.main.pressure.toString()} hPa'),
                  Text(
                      'Visibility: ${state.model.visibility.toString()} meters'),
                  if (state.model.rain != null)
                    Text(
                        'Rain Last Hour: ${state.model.rain!.the1H.toString()} mm'),
                  Text('Cloudiness: ${state.model.clouds.all.toString()}%'),
                  Text(
                      'Sunrise: ${DateTime.fromMillisecondsSinceEpoch(state.model.sys.sunrise * 1000, isUtc: true).toLocal()}'),
                  Text(
                      'Sunset: ${DateTime.fromMillisecondsSinceEpoch(state.model.sys.sunset * 1000, isUtc: true).toLocal()}'),
                ],
              ),
            ),
          );
        } else if (state is WeatherDataError) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return const Center(
            child: Text('Unknown error'),
          );
        }
      },
    );
  }
}
