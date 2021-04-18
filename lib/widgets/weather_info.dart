import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_simple_demo/bloc/weather_bloc.dart';

class WeatherInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (BuildContext context, state) {
        switch (state.status) {
          case WeatherStatus.loading:
            return Center(
                child: CircularProgressIndicator());
          case WeatherStatus.loaded:
            return Center(
                child: Container(
                    key: Key("weather-info"), child: Text("${state.weather.temp}")));
          default:
            return Center(
                child: Container(
                    key: Key("weather"), child: Text("Weather")));
        }
      },
    );
  }
}
