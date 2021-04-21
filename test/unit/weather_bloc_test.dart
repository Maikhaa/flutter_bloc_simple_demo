import 'package:flutter_bloc_simple_demo/bloc/weather_bloc.dart';
import 'package:flutter_bloc_simple_demo/data/weather_repo.dart';
import 'package:test/test.dart';

import '../mock_helpers/mock_client_helper.dart';

void main() {
  test("WeatherBloc maps getWeather event to loading state", () {
    final mockHelper = MockClientHelper();
    final mockClient = mockHelper.getMockClient;
    final weatherRepo = WeatherRepo(mockClient);
    final weatherBloc = WeatherBloc(weatherRepo);
    final weatherEvent = GetWeather("London");

    var result = weatherBloc.mapEventToState(weatherEvent);

    expect(result, emits(WeatherState(status: WeatherStatus.loading, weather: null)));

    weatherBloc.close();
  });
}