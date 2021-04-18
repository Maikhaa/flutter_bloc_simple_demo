import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc_simple_demo/main.dart';
import 'package:flutter_bloc_simple_demo/weather_info.dart';

void main() {
  testWidgets('Finds WeatherInfo', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Home()));
    var weatherInfo = find.byType(WeatherInfo);
    expect(weatherInfo, findsOneWidget);
  });
}