import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_simple_demo/data/weather_repo.dart';
import 'package:flutter_bloc_simple_demo/models/weather_model.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepo weatherRepo;

  WeatherBloc(this.weatherRepo)
     : super(WeatherState(status: WeatherStatus.initial));

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if (event is GetWeather) {
      yield state.copyWith(status: WeatherStatus.loading);

      try {
        var weather = await weatherRepo.getWeather(event.city);
        yield state.copyWith(status: WeatherStatus.loaded, weather: weather);
        return;
      } catch (_) {
        print(_);
        yield state.copyWith(status: WeatherStatus.error);
      }
    }
    yield state.copyWith(status: WeatherStatus.initial);
  }
}
