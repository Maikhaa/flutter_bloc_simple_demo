import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_simple_demo/bloc/weather_bloc.dart';
import 'package:flutter_bloc_simple_demo/data/weather_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc_simple_demo/main.dart';
import 'package:flutter_bloc_simple_demo/widgets/weather_info.dart';

import '../mock_helpers/mock_client_helper.dart';

void main() {
  final mockHelper = MockClientHelper();
  final mockClient = mockHelper.getMockClient;

  Widget setUpWidget(Widget widget) {
    return BlocProvider(
      create: (BuildContext context) => WeatherBloc(WeatherRepo(mockClient)),
      child: MaterialApp(
        home: widget,
      ),
    );
  }

  testWidgets('Finds WeatherInfo', (WidgetTester tester) async {
    await tester.pumpWidget(setUpWidget(Home()));
    var weatherInfo = find.byType(WeatherInfo);
    expect(weatherInfo, findsOneWidget);
  });

  testWidgets('WeatherInfo changes to loaded state', (WidgetTester tester) async {
    await tester.pumpWidget(setUpWidget(Home()));

    var textField = find.byKey(Key('search-input'));
    var searchButton = find.byKey(Key('search-button'));

    await tester.enterText(textField, "london");
    await tester.tap(searchButton);
    await tester.pump();

    expectLater(find.byKey(Key('weather-info')), findsOneWidget);
  });
}