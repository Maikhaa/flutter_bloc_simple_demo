import 'package:flutter_bloc_simple_demo/bloc/weather_bloc.dart';
import 'package:flutter_bloc_simple_demo/data/weather_repo.dart';
import 'package:test/test.dart';

void main() {
  test("WeatherBloc maps getWeather event to loaded state", () {
    var weatherRepo = WeatherRepo();
    var weatherBloc = WeatherBloc(weatherRepo);
    var weatherEvent = GetWeather("London");

    var result = weatherBloc.mapEventToState(weatherEvent);

    expect(result, emits(WeatherState(status: WeatherStatus.loaded)));

    weatherBloc.close();
  });
}