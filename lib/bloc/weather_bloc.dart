// Dart imports:
import 'dart:async';

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Project imports:
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
        yield state.copyWith(
            status: WeatherStatus.loadedMetric, weather: weather);
        return;
      } catch (_) {
        print(_);
        yield state.copyWith(status: WeatherStatus.error);
      }
    }

    if (event is ToggleWeatherUnits) {
      yield state.status == WeatherStatus.loadedMetric
          ? state.copyWith(status: WeatherStatus.loadedImperial)
          : state.copyWith(status: WeatherStatus.loadedMetric);
      return;
    }

    yield state.copyWith(status: WeatherStatus.initial);
  }
}
