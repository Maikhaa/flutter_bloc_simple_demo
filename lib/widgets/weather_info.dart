// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:flutter_bloc_simple_demo/bloc/weather_bloc.dart';
import 'package:flutter_bloc_simple_demo/utils/constants.dart';
import 'package:flutter_bloc_simple_demo/utils/temp_util.dart';

class WeatherInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tempUtil = TempUtil();

    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (BuildContext context, state) {
        switch (state.status) {
          case WeatherStatus.loading:
            return Center(
                child: SizedBox(
                    height: kstRegularBox,
                    width: kstRegularBox,
                    child: CircularProgressIndicator(
                      strokeWidth: 8.0,
                    )));
          case WeatherStatus.loadedMetric:
            return Center(
              key: Key("weather-info-metric"),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          state.weather!.date,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Text(state.weather!.city),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          tempUtil.getTempInC(state.weather!.temp),
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('↓' +
                                tempUtil.getTempInC(state.weather!.minTemp)),
                            SizedBox(width: kstRegularPadding),
                            Text('↑' +
                                tempUtil.getTempInC(state.weather!.maxTemp)),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: kstLargeBox,
                          width: kstLargeBox,
                          child: Image.asset(
                            'assets/images/${state.weather!.imgCode}.png',
                          ),
                        ),
                        SizedBox(height: kstSmallPadding),
                        Text(state.weather!.weather),
                      ],
                    ),
                  ]),
            );
          case WeatherStatus.loadedImperial:
            return Center(
              key: Key("weather-info-imperial"),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          state.weather!.date,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Text(state.weather!.city),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          tempUtil.getTempInF(state.weather!.temp),
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('↓' +
                                tempUtil.getTempInF(state.weather!.minTemp)),
                            SizedBox(width: kstRegularPadding),
                            Text('↑' +
                                tempUtil.getTempInF(state.weather!.maxTemp)),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: kstLargeBox,
                          width: kstLargeBox,
                          child: Image.asset(
                            'assets/images/${state.weather!.imgCode}.png',
                          ),
                        ),
                        SizedBox(height: kstSmallPadding),
                        Text(state.weather!.weather),
                      ],
                    ),
                  ]),
            );
          default:
            return Center(
              child: Column(children: [
                Text("Weather\nApp",
                    style: Theme.of(context).textTheme.headline1),
                SizedBox(
                  height: 120,
                  width: 120,
                  child: Image.asset('assets/images/s.png'),
                ),
              ]),
            );
        }
      },
    );
  }
}
