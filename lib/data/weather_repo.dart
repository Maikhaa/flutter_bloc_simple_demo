import 'package:flutter_bloc_simple_demo/models/weather_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../constants.dart';

class WeatherRepo {
  Future<WeatherModel?> getWeather(String city) async {
    final client = http.Client();

    final locationResponse = await getLocationResponse(client, city);
    final woeid = findWoeid(locationResponse);
    final weatherResponse = await getWeatherResponse(client, woeid);
    final weatherModel = createWeatherModel(weatherResponse);

    return weatherModel;
  }

  Future<http.Response> getLocationResponse(http.Client client, String city) async {
    final locationResponse =
        await client.get(Uri.https(kstBaseUrl, kstLocationPath, {'query': '$city'}));

    return locationResponse.statusCode == 200
        ? locationResponse
        : throw Exception('Failed to get location');
  }

  int findWoeid(http.Response? locationResponse) {
    if (locationResponse == null) return 0;
    var locationJson = jsonDecode(locationResponse.body);
    var woeid = locationJson[0]['woeid'];
    return woeid;
  }

  Future<http.Response> getWeatherResponse(http.Client client, woeid) async {
    final weatherResponse =
        await client.get(Uri.https(kstBaseUrl, '/api/location/$woeid/'));

    return weatherResponse.statusCode == 200
        ? weatherResponse
        : throw Exception('Failed to get weather info');
  }

  WeatherModel? createWeatherModel(http.Response? weatherResponse) {
    if (weatherResponse == null) return null;
    var weatherJson = jsonDecode(weatherResponse.body);
    var consolidatedWeatherJson = weatherJson['consolidated_weather'][0];
    return WeatherModel.fromJson(consolidatedWeatherJson);
  }
}
