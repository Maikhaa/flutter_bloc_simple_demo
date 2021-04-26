// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_simple_demo/widgets/refresh_button.dart';
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:flutter_bloc_simple_demo/bloc/weather_bloc.dart';
import 'package:flutter_bloc_simple_demo/data/weather_repo.dart';
import 'package:flutter_bloc_simple_demo/main.dart';
import '../mock_helpers/client_mock_helper.dart';

void main() {
  final mockHelper = ClientMockHelper();
  final mockClient = mockHelper.getMockClient;

  Widget setUpWidget(Widget widget) {
    return BlocProvider(
      create: (BuildContext context) => WeatherBloc(WeatherRepo(mockClient)),
      child: MaterialApp(
        home: widget,
      ),
    );
  }

  testWidgets('Finds RefreshButton in home after info loaded',
      (WidgetTester tester) async {
    await tester.pumpWidget(setUpWidget(Home()));

    var textField = find.byKey(Key('search-input'));
    var searchButton = find.byKey(Key('search-button'));

    await tester.enterText(textField, "london");
    await tester.tap(searchButton);
    await tester.pump();

    expect(find.byType(RefreshButton), findsOneWidget);
  });

  testWidgets('Finds weather info when pressed after info loaded',
      (WidgetTester tester) async {
    await tester.pumpWidget(setUpWidget(Home()));

    var textField = find.byKey(Key('search-input'));
    var searchButton = find.byKey(Key('search-button'));

    await tester.enterText(textField, "london");
    await tester.tap(searchButton);
    await tester.pump();

    var weatherInfo = find.byType(RefreshButton);
    await tester.tap(weatherInfo);
    await tester.pump();

    expect(find.byKey(Key('weather-info-metric')), findsOneWidget);
  });
}
