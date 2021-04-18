part of 'weather_bloc.dart';

enum WeatherStatus { initial, loaded }

class WeatherState extends Equatable {
  final WeatherStatus status;

  const WeatherState({@required this.status});

  WeatherState copyWith({
    WeatherStatus status,
  }) {
    return WeatherState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [status];
}
