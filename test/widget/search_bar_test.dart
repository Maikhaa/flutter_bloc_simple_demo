import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_bloc_simple_demo/bloc/weather_bloc.dart';
import 'package:flutter_bloc_simple_demo/data/weather_repo.dart';
import 'package:flutter_bloc_simple_demo/widgets/search_bar.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc_simple_demo/main.dart';
import 'package:flutter_bloc_simple_demo/constants.dart';

import '../unit/weather_repo_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  final mockClient = MockClient();
  final fakeCity = 'london';
  final fakeWoeid = 44418;
  final fakeLocationResponse =
      http.Response(KstFakeLocationResponseString, 200);
  final fakeWeatherResponse = http.Response(KstFakeWeatherResponseString, 200);

  when(mockClient
          .get(Uri.https(kstBaseUrl, kstLocationPath, {'query': '$fakeCity'})))
      .thenAnswer((_) async => fakeLocationResponse);

  when(mockClient.get(Uri.https(kstBaseUrl, kstLocationPath, {'query': ''})))
      .thenAnswer((_) async => http.Response('Not Found', 404));

  when(mockClient.get(Uri.https(kstBaseUrl, '/api/location/$fakeWoeid/')))
      .thenAnswer((_) async => fakeWeatherResponse);

  when(mockClient.get(Uri.https(kstBaseUrl, "/api/location/''/")))
      .thenAnswer((_) async => http.Response('Not Found', 404));

  Widget setUpWidget(Widget widget) {
    return BlocProvider(
      create: (BuildContext context) => WeatherBloc(WeatherRepo(mockClient)),
      child: MaterialApp(
        home: widget,
      ),
    );
  }

  testWidgets('Finds SearchBar in home', (WidgetTester tester) async {
    await tester.pumpWidget(setUpWidget(Home()));
    var weatherInfo = find.byType(SearchBar);
    expect(weatherInfo, findsOneWidget);
  });

  testWidgets('SearchBar changes to loaded state', (WidgetTester tester) async {
    await tester.pumpWidget(setUpWidget(Home()));

    var textField = find.byKey(Key('search-input'));
    var searchButton = find.byKey(Key('search-button'));

    await tester.enterText(textField, "london");
    await tester.tap(searchButton);
    await tester.pump();

    expectLater(find.byKey(Key('reset-button')), findsOneWidget);
  });
}
