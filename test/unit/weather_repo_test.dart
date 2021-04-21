import 'package:flutter_bloc_simple_demo/models/weather_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc_simple_demo/data/weather_repo.dart';
import '../mock_helpers/mock_client_helper.dart';

void main() {
  final mockHelper = MockClientHelper();
  final mockClient = mockHelper.getMockClient;
  final weatherRepo = WeatherRepo(mockClient);

  group('getLocationResponse', () {
    test('Throws exception when given an empty string', () async {
      var locationResponse = weatherRepo.getLocationResponse('');
      expect(locationResponse, throwsException);
    });
    test('Returns locationResponse when given city', () async {
      var locationResponse =
          weatherRepo.getLocationResponse(mockHelper.fakeCity);
      expect(await locationResponse, mockHelper.fakeLocationResponse);
    });
  });

  group('findWoeid', () {
    test('Returns 0 when given a null value', () async {
      var woeid = weatherRepo.findWoeid(null);
      expect(woeid, 0);
    });
    test('Returns woeid when given a locationResponse', () async {
      var woeid = weatherRepo.findWoeid(mockHelper.fakeLocationResponse);
      expect(woeid, mockHelper.fakeWoeid);
    });
  });

  group('getWeatherResponse', () {
    test('Throws exception when given an empty string', () async {
      var weatherResponse = weatherRepo.getLocationResponse('');
      expect(weatherResponse, throwsException);
    });
    test('Returns weatherResponse when given a woeid', () async {
      var weatherResponse =
          weatherRepo.getWeatherResponse(mockHelper.fakeWoeid);
      expect(await weatherResponse, mockHelper.fakeWeatherResponse);
    });
  });

  group('createWeatherModel', () {
    test('Returns null when given a null value', () async {
      var weatherModel = weatherRepo.createWeatherModel(null);
      expect(weatherModel, null);
    });
    test('Returns weatherModel when given a weatherResponse', () async {
      var weatherModel =
          weatherRepo.createWeatherModel(mockHelper.fakeWeatherResponse);
      expect(weatherModel, isA<WeatherModel>());
    });
  });
}
