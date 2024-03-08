import 'dart:convert';
import 'package:http/http.dart' as http;

import 'model/weather_model.dart';

class WeatherRepository {
  final String _baseUrl = "https://api.openweathermap.org/data/2.5/weather";
  final String _apiKey = "a10bb3b0eb32899fd58d5b93728efe87";

  Future<WeatherModel> fetchWeather(double lat, double lon) async {
    final response = await http.get(
      Uri.parse("$_baseUrl?lat=$lat&lon=$lon&appid=$_apiKey"),
    );

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      if (jsonBody is Map<String, dynamic>) {
        return WeatherModel.fromJson(jsonBody);
      } else {
        throw const FormatException('Invalid response format');
      }
    } else {
      throw Exception('Failed to load weather');
    }
  }
}
