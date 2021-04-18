import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_simple_demo/constants.dart';
import 'bloc/weather_bloc.dart';

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
        padding: const EdgeInsets.only(right: smallPadding, left: smallPadding),
        child: Row(children: [
          Expanded(
            flex: 9,
            child: TextField(
              controller: searchCityController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: "Search cities",
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.blueGrey),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: BlocBuilder<WeatherBloc, WeatherState>(
                builder: (context, state) {
              if (state is WeatherIsLoaded) {
                return IconButton(
                  key: Key('reset-button'),
                  icon: Icon(Icons.close),
                  onPressed: () {
                    weatherBloc.add(GetWeather(searchCityController));
                  },
                );
              }
              return IconButton(
                key: Key('search-button'),
                icon: Icon(Icons.search),
                onPressed: () {
                  weatherBloc.add(GetWeather(searchCityController));
                },
              );
            }),
          ),
        ]),
      ),
    );
  }
}
