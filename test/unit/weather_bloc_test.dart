// Package imports:
import 'package:test/test.dart';

// Project imports:
import 'package:flutter_bloc_simple_demo/bloc/weather_bloc.dart';
import '../mock_helpers/weather_repo_mock_helper.dart';

void main() {
  final weatherMockHelper = WeatherRepoMockHelper();
  final mockWeatherRepo = weatherMockHelper.getMockWeatherRepo;
  final weatherBloc = WeatherBloc(mockWeatherRepo);

  test('WeatherBloc initial state is correct', () {
    var result = weatherBloc.state;
    expect(result, WeatherState(status: WeatherStatus.initial));
  });

  test("WeatherBloc maps GetWeather event to loading state", () {
    final weatherEvent = GetWeather("london");
    var result = weatherBloc.mapEventToState(weatherEvent);
    expect(result, emits(WeatherState(status: WeatherStatus.loading)));
  });

  test("WeatherBloc maps GetWeather event to loaded state", () async {
    final weatherEvent = GetWeather("london");
    final result = weatherBloc.mapEventToState(weatherEvent);
    var fakeWeatherModel = await mockWeatherRepo.getWeather('london');
    expectLater(
        result,
        emitsThrough(WeatherState(
            status: WeatherStatus.loadedMetric, weather: fakeWeatherModel)));
  });

  test("WeatherBloc maps GetWeather event to error state", () {
    final weatherEvent = GetWeather("");
    var result = weatherBloc.mapEventToState(weatherEvent);
    expect(result, emitsThrough(WeatherState(status: WeatherStatus.error)));
  });

  test("WeatherBloc maps ResetWeather event to initial state", () {
    final weatherEvent = ResetWeather();
    var result = weatherBloc.mapEventToState(weatherEvent);
    expect(result, emitsThrough(WeatherState(status: WeatherStatus.initial)));
  });

  tearDown(() {
    weatherBloc.close();
  });
}
