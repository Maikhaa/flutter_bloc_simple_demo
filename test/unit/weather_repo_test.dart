import 'package:flutter_bloc_simple_demo/models/weather_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc_simple_demo/data/weather_repo.dart';
import '../mock_helpers/client_mock_helper.dart';

void main() {
  final clientMockHelper = ClientMockHelper();
  final mockClient = clientMockHelper.getMockClient;
  final weatherRepo = WeatherRepo(mockClient);

  group('formatCity', () {
    test('Returns empty string, when given empty string', () {
      var formattedCity = weatherRepo.formatCity('');
      expect(formattedCity, '');
    });
    test('Returns trimmed, lowercase when given uppercase, untrimmed', () {
      var formattedCity = weatherRepo.formatCity('London ');
      expect(formattedCity, 'london');
    });
  });

  group('getLocationResponse', () {
    test('Throws exception when given an empty string', () async {
      var locationResponse = weatherRepo.getLocationResponse('');
      expect(locationResponse, throwsException);
    });
    test('Returns locationResponse when given city', () async {
      var locationResponse =
          weatherRepo.getLocationResponse(clientMockHelper.fakeCity);
      expect(await locationResponse, clientMockHelper.fakeLocationResponse);
    });
  });

  group('findWoeid', () {
    test('Returns 0 when given a null value', () async {
      var woeid = weatherRepo.findWoeid(null);
      expect(woeid, 0);
    });
    test('Returns woeid when given a locationResponse', () async {
      var woeid = weatherRepo.findWoeid(clientMockHelper.fakeLocationResponse);
      expect(woeid, clientMockHelper.fakeWoeid);
    });
  });

  group('findCityName', () {
    test('Returns empty string when given a null value', () async {
      var cityName = weatherRepo.findCityName(null);
      expect(cityName, '');
    });
    test('Returns cityName when given a locationResponse', () async {
      var cityName = weatherRepo.findCityName(clientMockHelper.fakeLocationResponse);
      expect(cityName, clientMockHelper.fakeCity);
    });
  });

  group('getWeatherResponse', () {
    test('Throws exception when given an empty string', () async {
      var weatherResponse = weatherRepo.getLocationResponse('');
      expect(weatherResponse, throwsException);
    });
    test('Returns weatherResponse when given a woeid', () async {
      var weatherResponse =
          weatherRepo.getWeatherResponse(clientMockHelper.fakeWoeid);
      expect(await weatherResponse, clientMockHelper.fakeWeatherResponse);
    });
  });

  group('createWeatherModel', () {
    test('Returns null when given a null value and an empty string', () async {
      var weatherModel = weatherRepo.createWeatherModel(null, '');
      expect(weatherModel, null);
    });
    test('Returns weatherModel when given a weatherResponse and a city', () async {
      var weatherModel = weatherRepo.createWeatherModel(
          clientMockHelper.fakeWeatherResponse, clientMockHelper.fakeCity);
      expect(weatherModel, isA<WeatherModel>());
    });
  });
}
