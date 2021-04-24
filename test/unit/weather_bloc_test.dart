import 'package:flutter_bloc_simple_demo/bloc/weather_bloc.dart';
import 'package:test/test.dart';

import '../mock_helpers/weather_repo_mock_helper.dart';

void main() {
  final mockHelper = WeatherRepoMockHelper();
  final mockWeatherRepo = mockHelper.getMockWeatherRepo;
  final weatherBloc = WeatherBloc(mockWeatherRepo);

  test('WeatherBloc initial state is correct', () {
    var result = weatherBloc.state;
    expect(result, WeatherState(status: WeatherStatus.initial));
  });

  test("WeatherBloc maps getWeather event to loading state", () {
    final weatherEvent = GetWeather("london");
    var result = weatherBloc.mapEventToState(weatherEvent);
    expect(result, emits(WeatherState(status: WeatherStatus.loading)));
  });

  test("WeatherBloc maps getWeather event to loaded state", () async {
    final weatherEvent = GetWeather("london");
    final result = weatherBloc.mapEventToState(weatherEvent);
    var model = await mockWeatherRepo.getWeather('london');
    expectLater(
        result,
        emitsThrough(
            WeatherState(status: WeatherStatus.loaded, weather: model)));
  });

  test("WeatherBloc maps getWeather event to error state", () {
    final weatherEvent = GetWeather("");
    var result = weatherBloc.mapEventToState(weatherEvent);
    expect(result, emitsThrough(WeatherState(status: WeatherStatus.error)));
  });

  tearDown(() {
    weatherBloc.close();
  });
}
