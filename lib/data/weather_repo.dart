import 'package:flutter_bloc_simple_demo/models/weather_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherRepo {
  Future<WeatherModel> getWeather(String city) async {
    final String _baseUrl = 'www.metaweather.com';
    final String _path = '/api/location/search/';
    final Map<String, String> _queryParameters = <String, String>{
      'query': '$city',
    };
    final locationResponse = await http
        .get(Uri.https(_baseUrl, _path, _queryParameters ));

    if (locationResponse.statusCode == 200) {
      var locationJson = jsonDecode(locationResponse.body);
      var woeid = locationJson[0]['woeid'];

      final weatherResponse = await http
            .get(Uri.https('www.metaweather.com', '/api/location/$woeid/'));

      if (weatherResponse.statusCode == 200) {
          var weatherJson = jsonDecode(weatherResponse.body);
          var consolidatedWeatherJson = weatherJson['consolidated_weather'][0];
          print(WeatherModel.fromJson(consolidatedWeatherJson).temp);
          return WeatherModel.fromJson(consolidatedWeatherJson);
      } else {
        throw Exception('Failed to get weather');
      }

    } else {
      throw Exception('Failed to get location');
    }
  }
}
