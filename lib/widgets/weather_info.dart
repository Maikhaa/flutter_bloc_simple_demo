import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_simple_demo/bloc/weather_bloc.dart';
import 'package:flutter_bloc_simple_demo/utils/temp_util.dart';

class WeatherInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tempUtil = TempUtil();
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (BuildContext context, state) {
        switch (state.status) {
          case WeatherStatus.loading:
            return Center(child: CircularProgressIndicator());
          case WeatherStatus.loadedMetric:
            return Center(
              key: Key("weather-info"),
              child: Column(key: Key("weather-info"), children: [
                Text(state.weather!.date),
                Text(state.weather!.city),
                Text(tempUtil.getTempInC(state.weather!.temp)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(tempUtil.getTempInC(state.weather!.minTemp)),
                    SizedBox(width: 50),
                    Text(tempUtil.getTempInC(state.weather!.maxTemp)),
                  ],
                )
              ]),
            );
          case WeatherStatus.loadedImperial:
            return Center(
              child: Container(
                key: Key("weather-info"),
                child: Column(key: Key("weather-info"), children: [
                  Text(state.weather!.date),
                  Text(state.weather!.city),
                  Text(tempUtil.getTempInF(state.weather!.temp)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(tempUtil.getTempInF(state.weather!.minTemp)),
                      SizedBox(width: 50),
                      Text(tempUtil.getTempInF(state.weather!.maxTemp)),
                    ],
                  )
                ]),
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
