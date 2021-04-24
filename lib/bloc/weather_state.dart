part of 'weather_bloc.dart';

enum WeatherStatus { initial, loading, loaded, error }

class WeatherState extends Equatable {
  final WeatherStatus? status;
  final WeatherModel? weather;

  const WeatherState({this.status, this.weather});

  WeatherState copyWith({
    WeatherStatus? status,
    WeatherModel? weather
  }) {
    return WeatherState(
      status: status ?? this.status,
      weather: weather ?? this.weather,
    );
  }

  @override
  List<Object?> get props => [status, weather];
}
