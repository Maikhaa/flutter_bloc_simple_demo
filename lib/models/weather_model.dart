import 'package:flutter/material.dart';

class WeatherModel {
  final String date;
  final String weather;
  final String temp;
  final String maxTemp;
  final String minTemp;

  WeatherModel(
      {@required this.date,
      @required this.weather,
      @required this.temp,
      @required this.maxTemp,
      @required this.minTemp});

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      date: json['applicable_date'],
      weather: json['weather_state_name'],
      temp: json['the_temp'].toStringAsFixed(2),
      maxTemp: json['max_temp'].toStringAsFixed(2),
      minTemp: json['min_temp'].toStringAsFixed(2)
    );
  }
}
