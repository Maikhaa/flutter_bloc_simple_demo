import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_simple_demo/bloc/weather_bloc.dart';
import 'package:flutter_bloc_simple_demo/services/temp_converter.dart';

class WeatherInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tempConverter = TempConverter();
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (BuildContext context, state) {
        switch (state.status) {
          case WeatherStatus.loading:
            return Center(child: CircularProgressIndicator());
          case WeatherStatus.loadedMetric:
            return Center(
              child: Column(key: Key("weather-info"), children: [
                Text(state.weather!.date),
                Text(state.weather!.city),
                Text(state.weather!.temp.toStringAsFixed(2) + ' °C'),
              ]),
            );
          case WeatherStatus.loadedImperial:
            return Center(
              child: Container(
                key: Key("weather-info"),
                child: Text(
                    tempConverter.toF(state.weather!.temp).toStringAsFixed(2) +
                        ' °F'),
              ),
            );
          default:
            return Center(
                child: Container(key: Key("weather"), child: Text("Weather")));
        }
      },
    );
  }
}
