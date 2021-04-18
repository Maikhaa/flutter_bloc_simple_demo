part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class GetWeather extends WeatherEvent{
  final city;

  GetWeather(this.city);

  @override
  List<Object> get props => [city];
}