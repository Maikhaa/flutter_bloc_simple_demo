// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:flutter_bloc_simple_demo/bloc/weather_bloc.dart';

class SwitchUnits extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final weatherBloc = BlocProvider.of<WeatherBloc>(context);
    var isCelsius = true;

    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (BuildContext context, state) {
        switch (state.status) {
          case WeatherStatus.loadedMetric:
          case WeatherStatus.loadedImperial:
            return Container(
              child: SwitchListTile(
                key: Key('switch-button'),
                contentPadding: const EdgeInsets.all(0.0),
                value: isCelsius,
                onChanged: (value) {
                  isCelsius = value;
                  weatherBloc.add(ToggleWeatherUnits());
                },
              ),
            );
          default:
            return Container();
        }
      },
    );
  }
}
