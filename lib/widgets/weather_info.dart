import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            return Center(child: CircularProgressIndicator());
          case WeatherStatus.loadedMetric:
            return Center(
              key: Key("weather-info"),
              child: Column(key: Key("weather-info"), children: [
                Text(
                  state.weather!.date,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Text(state.weather!.city),
                SizedBox(height: kstLargePadding),
                Text(
                  tempUtil.getTempInC(state.weather!.temp),
                  style: Theme.of(context).textTheme.headline1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(tempUtil.getTempInC(state.weather!.minTemp)),
                    SizedBox(width: kstRegularPadding),
                    Text(tempUtil.getTempInC(state.weather!.maxTemp)),
                  ],
                ),
                SizedBox(
                  height: kstLargeBox,
                  width: kstLargeBox,
                  child: Image.network(
                    'https://www.metaweather.com/static/img/weather/png/${state.weather!.imgCode}.png',
                  ),
                ),
              ]),
            );
          case WeatherStatus.loadedImperial:
            return Center(
              child: Container(
                key: Key("weather-info"),
                child: Column(key: Key("weather-info"), children: [
                  Text(
                    state.weather!.date,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(state.weather!.city),
                  SizedBox(height: kstLargePadding),
                  Text(
                    tempUtil.getTempInF(state.weather!.temp),
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(tempUtil.getTempInF(state.weather!.minTemp)),
                      SizedBox(width: kstRegularPadding),
                      Text(tempUtil.getTempInF(state.weather!.maxTemp)),
                    ],
                  ),
                  SizedBox(
                    height: kstLargeBox,
                    width: kstLargeBox,
                    child: Image.network(
                      'https://www.metaweather.com/static/img/weather/png/${state.weather!.imgCode}.png',
                    ),
                  ),
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
