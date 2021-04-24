import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_simple_demo/constants.dart';
import '../bloc/weather_bloc.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController searchCityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final weatherBloc = BlocProvider.of<WeatherBloc>(context);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
            right: kstSmallPadding, left: kstSmallPadding),
        child: Row(children: [
          Expanded(
            flex: 9,
            child: BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                switch (state.status) {
                  case WeatherStatus.loaded:
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
                        hintStyle: TextStyle(color: Colors.blueGrey),
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
                        hintStyle: TextStyle(color: Colors.blueGrey),
                      ),
                    );
                }
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: BlocBuilder<WeatherBloc, WeatherState>(
                builder: (context, state) {
              switch (state.status) {
                case WeatherStatus.loading:
                  return Container(
                      child: CircularProgressIndicator(strokeWidth: 3.0));
                case WeatherStatus.loaded:
                  return IconButton(
                    key: Key('reset-button'),
                    icon: Icon(Icons.close),
                    onPressed: () {
                      weatherBloc.add(ResetWeather());
                      searchCityController.clear();
                    },
                  );
                default:
                  return IconButton(
                    key: Key('search-button'),
                    icon: Icon(Icons.search),
                    onPressed: () {
                      weatherBloc.add(GetWeather(searchCityController.text));
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
