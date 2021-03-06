// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:http/http.dart' as http;

// Project imports:
import 'package:flutter_bloc_simple_demo/models/weather_model.dart';
import 'package:flutter_bloc_simple_demo/utils/constants.dart';

class WeatherRepo {
  http.Client client;

  WeatherRepo(this.client);

  Future<WeatherModel?> getWeather(String city) async {
    final formattedCity = formatCity(city);
    final locationResponse = await getLocationResponse(formattedCity);
    final woeid = findWoeid(locationResponse);
    final cityName = findCityName(locationResponse);
    final weatherResponse = await getWeatherResponse(woeid);
    final weatherModel = createWeatherModel(weatherResponse, cityName);

    return weatherModel;
  }

  String formatCity(String city) {
    if (city == '') return '';

    return city.trim().toLowerCase();
  }

  Future<http.Response> getLocationResponse(String city) async {
    final locationResponse = await client
        .get(Uri.https(kstBaseUrl, kstLocationPath, {'query': '$city'}));

    return locationResponse.statusCode == 200
        ? locationResponse
        : throw Exception('Failed to get location');
  }

  int findWoeid(http.Response? locationResponse) {
    if (locationResponse == null) return 0;

    final locationJson = jsonDecode(locationResponse.body);
    final woeid = locationJson[0]['woeid'];
    return woeid;
  }

  String findCityName(http.Response? locationResponse) {
    if (locationResponse == null) return '';

    final locationJson = jsonDecode(locationResponse.body);
    final cityName = locationJson[0]['title'];
    return cityName;
  }

  Future<http.Response> getWeatherResponse(woeid) async {
    final weatherResponse =
        await client.get(Uri.https(kstBaseUrl, '/api/location/$woeid/'));

    return weatherResponse.statusCode == 200
        ? weatherResponse
        : throw Exception('Failed to get weather info');
  }

  WeatherModel? createWeatherModel(
      http.Response? weatherResponse, String cityName) {
    if (weatherResponse == null) return null;

    final weatherJson = jsonDecode(weatherResponse.body);
    weatherJson['consolidated_weather'][0]['city'] = cityName;

    final consolidatedWeatherJson = weatherJson['consolidated_weather'][0];
    return WeatherModel.fromJson(consolidatedWeatherJson);
  }
}
