import 'package:flutter_bloc_simple_demo/constants.dart';
import 'package:flutter_bloc_simple_demo/models/weather_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_bloc_simple_demo/data/weather_repo.dart';

import 'weather_repo_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  final mockClient = MockClient();
  final fakeCity = 'london';
  final fakeWoeid = 44418;
  final fakeLocationResponse =
      http.Response(KstFakeLocationResponseString, 200);
  final fakeWeatherResponse = http.Response(KstFakeWeatherResponseString, 200);

  when(mockClient
          .get(Uri.https(kstBaseUrl, kstLocationPath, {'query': '$fakeCity'})))
      .thenAnswer((_) async => fakeLocationResponse);

  when(mockClient.get(Uri.https(kstBaseUrl, kstLocationPath, {'query': ''})))
      .thenAnswer((_) async => http.Response('Not Found', 404));

  when(mockClient.get(Uri.https(kstBaseUrl, '/api/location/$fakeWoeid/')))
      .thenAnswer((_) async => fakeWeatherResponse);

  when(mockClient.get(Uri.https(kstBaseUrl, "/api/location/''/")))
      .thenAnswer((_) async => http.Response('Not Found', 404));

  final weatherRepo = WeatherRepo();

  group('getLocationResponse', () {
    test('Throws exception when given an empty string', () async {
      var locationResponse = weatherRepo.getLocationResponse(mockClient, '');
      expect(locationResponse, throwsException);
    });
    test('Returns locationResponse when given city', () async {
      var locationResponse =
          weatherRepo.getLocationResponse(mockClient, fakeCity);
      expect(await locationResponse, fakeLocationResponse);
    });
  });

  group('findWoeid', () {
    test('Returns 0 when given a null value', () async {
      var woeid = weatherRepo.findWoeid(null);
      expect(woeid, 0);
    });
    test('Returns woeid when given a locationResponse', () async {
      var woeid = weatherRepo.findWoeid(fakeLocationResponse);
      expect(woeid, fakeWoeid);
    });
  });

  group('getWeatherResponse', () {
    test('Throws exception when given an empty string', () async {
      var weatherResponse = weatherRepo.getLocationResponse(mockClient, '');
      expect(weatherResponse, throwsException);
    });
    test('Returns weatherResponse when given a woeid', () async {
      var weatherResponse =
          weatherRepo.getWeatherResponse(mockClient, fakeWoeid);
      expect(await weatherResponse, fakeWeatherResponse);
    });
  });

  group('createWeatherModel', () {
    test('Returns null when given a null value', () async {
      var weatherModel = weatherRepo.createWeatherModel(null);
      expect(weatherModel, null);
    });
    test('Returns weatherModel when given a weatherResponse', () async {
      var weatherModel = weatherRepo.createWeatherModel(fakeWeatherResponse);
      expect(weatherModel, isA<WeatherModel>());
    });
  });
}
