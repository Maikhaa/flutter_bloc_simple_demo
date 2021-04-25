import 'package:flutter_bloc_simple_demo/data/weather_repo.dart';
import 'package:flutter_bloc_simple_demo/models/weather_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'weather_repo_mock_helper.mocks.dart';

@GenerateMocks([WeatherRepo])
class WeatherRepoMockHelper {
  final mockWeatherRepo = MockWeatherRepo();

  final fakeWeatherModel = WeatherModel(
    city: 'London',
    date: '2021-04-21',
    weather: 'Heavy Cloud',
    imgCode: 'hc',
    temp: 13.72,
    maxTemp: 13.81,
    minTemp: 5.84,
  );

  MockWeatherRepo get getMockWeatherRepo {
    when(mockWeatherRepo.getWeather("london"))
        .thenAnswer((_) async => fakeWeatherModel);

    return mockWeatherRepo;
  }
}
