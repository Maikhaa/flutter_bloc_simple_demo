part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class GetWeather extends WeatherEvent {
  final String city;

  GetWeather(this.city);

  @override
  List<Object> get props => [city];
}

class ResetWeather extends WeatherEvent {
  @override
  List<Object> get props => [];
}

class ToggleWeatherUnits extends WeatherEvent {
  @override
  List<Object> get props => [];
}
