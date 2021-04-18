import 'package:flutter/material.dart';
import 'package:flutter_bloc_simple_demo/widgets/search_bar.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc_simple_demo/main.dart';

void main() {
  testWidgets('Finds SearchBar', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Home()));
    var weatherInfo = find.byType(SearchBar);
    expect(weatherInfo, findsOneWidget);
  });

  testWidgets('SearchBar changes to loaded state', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Home()));

    var textField = find.byType(TextField);
    var searchButton = find.byKey(Key('search-button'));

    await tester.enterText(textField, "London");
    await tester.tap(searchButton);
    await tester.pump();

    expect(find.byKey(Key('reset-button')), findsOneWidget);
  });
}
