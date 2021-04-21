import 'package:flutter_bloc_simple_demo/models/weather_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../constants.dart';

class WeatherRepo {
  http.Client client;

  WeatherRepo(this.client);

  Future<WeatherModel?> getWeather(String city) async {
    final locationResponse = await getLocationResponse(city);
    final woeid = findWoeid(locationResponse);
    final weatherResponse = await getWeatherResponse(woeid);
    final weatherModel = createWeatherModel(weatherResponse);

    return weatherModel;
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
    var locationJson = jsonDecode(locationResponse.body);
    var woeid = locationJson[0]['woeid'];
    return woeid;
  }

  Future<http.Response> getWeatherResponse(woeid) async {
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
