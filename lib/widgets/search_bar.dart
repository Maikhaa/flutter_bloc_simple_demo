import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_simple_demo/utils/constants.dart';
import '../bloc/weather_bloc.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final weatherBloc = BlocProvider.of<WeatherBloc>(context);
    final TextEditingController searchCityController = TextEditingController();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(3.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
            right: kstSmallPadding, left: kstSmallPadding),
        child: Row(children: [
          Expanded(
            child: BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                switch (state.status) {
                  case WeatherStatus.loadedMetric:
                  case WeatherStatus.loadedImperial:
                    return TextField(
                      onTap: () {
                        weatherBloc.add(ResetWeather());
                        searchCityController.clear();
                      },
                      key: Key('search-input'),
                      controller: searchCityController,
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: "Search cities",
                        border: InputBorder.none,
                      ),
                    );
                  default:
                    return TextField(
                      key: Key('search-input'),
                      controller: searchCityController,
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: "Search cities",
                        border: InputBorder.none,
                      ),
                    );
                }
              },
            ),
          ),
          Container(
            width: kstSmallBox,
            child: BlocBuilder<WeatherBloc, WeatherState>(
                builder: (context, state) {
              switch (state.status) {
                case WeatherStatus.loading:
                  return SizedBox(
                    child: CircularProgressIndicator(strokeWidth: 4.0),
                    height: kstSmallBox,
                    width: kstSmallBox,
                  );
                case WeatherStatus.loadedMetric:
                case WeatherStatus.loadedImperial:
                  return IconButton(
                    key: Key('reset-button'),
                    icon: Icon(
                      Icons.close,
                      color: Colors.blueGrey,
                    ),
                    onPressed: () {
                      weatherBloc.add(ResetWeather());
                      searchCityController.clear();
                    },
                  );
                default:
                  return IconButton(
                    key: Key('search-button'),
                    icon: Icon(
                      Icons.search,
                      color: Colors.blueGrey,
                    ),
                    onPressed: () {
                      weatherBloc.add(GetWeather(searchCityController.text));
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                  );
              }
            }),
          ),
        ]),
      ),
    );
  }
}
