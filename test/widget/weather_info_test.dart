import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc_simple_demo/main.dart';
import 'package:flutter_bloc_simple_demo/widgets/weather_info.dart';

void main() {
  testWidgets('Finds WeatherInfo', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Home()));
    var weatherInfo = find.byType(WeatherInfo);
    expect(weatherInfo, findsOneWidget);
  });

  testWidgets('WeatherInfo changes to loaded state', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Home()));

    var textField = find.byKey(Key('search-input'));
    var searchButton = find.byKey(Key('search-button'));

    await tester.enterText(textField, "London");
    await tester.tap(searchButton);
    await tester.pump();

    expect(find.byKey(Key('weather-info')), findsOneWidget);
  });
}